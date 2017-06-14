require "beanstalk_deploy/command/base"

module BeanstalkDeploy::Command
  class SSH < Base
    def initialize(environment, printer)
      @environment = environment
      @printer = printer
    end

    def execute
      ip_address = environment.instances.map(&:private_ip_address).compact.sample

      begin
        printer.line "Connecting to #{ip_address} in #{environment.beanstalk_environment_name} [#{environment.cname}]"
        system "ssh -F ./ssh.cfg #{ip_address}"
      rescue
        printer.line "ssh failed: most likely don't have ssh key in the right location"
      end
    end

    private

    attr_reader :environment
  end
end
