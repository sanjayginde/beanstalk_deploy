require "beanstalk_deploy/command/base"

module BeanstalkDeploy::Command
  class Clobber < Base
    def initialize(config, printer)
      @config = config
      @printer = printer
    end

    def execute
      FileUtils.rm_r package_dir rescue nil
      printer.line "Clobbered #{package_dir}."
    end

    private

    attr_reader :config

    def package_dir
      config.package_dir
    end
  end
end
