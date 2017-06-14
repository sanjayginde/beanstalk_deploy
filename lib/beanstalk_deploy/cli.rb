require "thor"

module BeanstalkDeploy
  class CLI < ::Thor
    class_option :verbose, type: :boolean, aliases: :v

    desc "status ENVIRONMENT_NAME", "Check status for an environment"
    def status(environment_name)
      deploy_env = Application.new(application_name).environment(environment_name)
      command = Command::Status.new(deploy_env, printer)
      command.execute
    end

    no_commands do
      def printer
        @printer ||= Printer.new
      end

      def verbose?
        options[:verbose]
      end

      def application_name
        @application_name ||= YAML::load_file("config/eb_deployer.yml")["application"]
      end
    end
  end
end
