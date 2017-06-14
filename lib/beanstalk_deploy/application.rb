require "eb_deployer"

module BeanstalkDeploy
  class Application
    attr_reader :name, :beanstalk_client

    def initialize(name)
      @name = name
      @environments = {}

      @beanstalk_client = Aws::ElasticBeanstalk::Client.new
    end

    def environment(environment_name)
      result = @environments[environment_name]
      if result.blank?
        beanstalk_env_name = EbDeployer::EbEnvironment.unique_ebenv_name(environment_name, name)
        environment_info = @beanstalk_client
          .describe_environments(application_name: name, environment_names: [beanstalk_env_name])[:environments]
          .first
        result = Environment.new(environment_name, environment_info)
      end
      result
    end

    def delete_old_app_versions(delete_source_bundle: true)
      versions = @beanstalk_client
        .describe_application_versions(application_name: name)[:application_versions]

      deployed_version_labels = @beanstalk_client
        .describe_environments(application_name: name)[:environments]
        .collect(&:version_label)

      puts deployed_version_labels
      versions.each do |version|
        label = version.version_label
        unless deployed_version_labels.include? label
          puts "Deleting #{version.version_label}"
          options = {
            application_name: name,
            version_label: label,
            delete_source_bundle: delete_source_bundle
          }

          @beanstalk_client.delete_application_version(options)
        else
          puts "** Skipping #{label}"
        end
      end
    end
  end
end
