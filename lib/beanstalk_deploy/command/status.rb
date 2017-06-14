require "beanstalk_deploy/command/base"

module BeanstalkDeploy::Command
  class Status < Base
    def initialize(environment, printer)
      @environment = environment
      @printer = printer
    end

    def execute
      printer.hash data
      printer.spacer
      printer.table environment.instances, :instance_id, :availability_zone, :private_ip_address
      printer.spacer
    end

    private

    attr_reader :environment

    def data
      {
        "Environment": environment.beanstalk_environment_name,
        "Version": environment.version_label,
        "Created at": environment.date_created,
        "Updated at": environment.date_updated,
        "Status": environment.status,
        "CNAME": environment.cname,
        "Health": environment.health
      }
    end
  end
end
