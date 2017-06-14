module BeanstalkDeploy
  class Environment
    attr_reader :name, :environment_info

    delegate :application_name, :version_label, :cname,
      :date_created, :date_updated, :status, :health,
      to: :environment_info

    def initialize(environment_name, environment_info)
      @name = environment_name
      @environment_info = environment_info

      @ec2_resource = Aws::EC2::Resource.new
      @beanstalk_client = Aws::ElasticBeanstalk::Client.new
    end

    def beanstalk_environment_name
      @environment_info.environment_name
    end

    def instances
      @instances ||= @ec2_resource
        .instances(filters: [beanstalk_environment_name_filter])
        .map do |ec2_instance|
          Instance.new(ec2_instance)
        end
    end

    def rebuild!
      @beanstalk_client.rebuild_environment(environment_name: beanstalk_environment_name)
    end

    def restart!
      @beanstalk_client.restart_app_server(environment_name: beanstalk_environment_name)
    end

    protected

    def beanstalk_environment_name_filter
      {
        name: "tag:elasticbeanstalk:environment-name",
        values: [beanstalk_environment_name]
      }
    end
  end
end
