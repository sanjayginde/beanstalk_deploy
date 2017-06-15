require "thor"

module BeanstalkDeploy
  class CLI < ::Thor
    class_option :verbose, type: :boolean, aliases: :v

    desc "status ENVIRONMENT_NAME", "Check status for an environment"
    def status(environment_name)
      Command::Status.new(environment(environment_name), printer).execute
    end

    desc "ssh ENVIRONMENT_NAME", "SSH to a box in an environment"
    def ssh(environment_name)
      Command::SSH.new(environment(environment_name), printer).execute
    end

    desc "clobber", "Remove any generated packages directory"
    def clobber
      Command::Clobber.new(config, printer).execute
    end

    desc "package", "Package for deployment"
    def package
      clobber
      Command::Package.new(config, printer).execute
    end

    no_commands do
      def printer
        @printer ||= Printer.new
      end

      def verbose?
        options[:verbose]
      end

      def environment(environment_name)
        application.environment(environment_name)
      end

      def application
        @application ||= Application.new(application_name)
      end

      def application_name
        @application_name ||= YAML::load_file("config/eb_deployer.yml")["application"]
      end

      def config
        @config ||= Config.new(config_file)
      end

      def config_file
        "config/beanstalk_deploy.yml"
      end
    end
  end
end
