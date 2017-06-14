module BeanstalkDeploy
  class Instance
    attr_reader :ec2_instance

    delegate :instance_id, :name, :vpc_id, :launch_time,
      :subnet_id, :private_ip_address, :public_ip_address,
      to: :ec2_instance

    def initialize(ec2_instance)
      @ec2_instance = ec2_instance
    end

    def availability_zone
      ec2_instance.placement.availability_zone
    end
  end
end
