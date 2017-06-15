require "beanstalk_deploy/command/base"

# Packaging code based on elastic-beanstalk gem.
# https://github.com/alienfast/elastic-beanstalk/blob/master/lib/elastic/beanstalk/tasks/eb.rake
module BeanstalkDeploy::Command
  class Package < Base
    def initialize(config, printer)
      @config = config
      @printer = printer
    end

    def execute
      includes =  %w(**/* .ebextensions/**/*)
      exclude_files = %w(.*)
      exclude_dirs = %w(pkg tmp data log test-reports perf spec vendor public/system
                        public/assets script/travis log doc chef .git .bundle .idea tools)

      # include all
      files = FileList[includes]

      # exclude files
      exclude_files.each do |file|
        files.exclude(file)
      end

      exclude_dirs.each do |dir|
        files.exclude("#{dir}/**/*")
        files.exclude("#{dir}")
      end

      FileUtils.mkdir_p package_dir rescue nil

      Zip::File.open(package_file, Zip::File::CREATE) do |archive|
        log "\nCreating archive (#{package_file}):" if verbose?
        files.each do |file|
          if File.directory? file
            log "\t#{file}" if verbose?
          else
            log "\t\t#{file}" if verbose?
          end
          archive.add(file, file)
        end
      end

      log "\nFinished creating archive (#{package_file})."
    end

    private

    attr_reader :config

    def package_dir
      config.package_dir
    end
  end
end
