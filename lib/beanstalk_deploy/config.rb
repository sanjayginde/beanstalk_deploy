module BeanstalkDeploy
  class Config
    def initialize(yaml_file)
      @config = YAML::load_file(yaml_file)
    end

    def package_file
      "#{package_dir}/#{package_file_name}"
    end

    def package_dir
      @config["package"]["directory"] || "pkg"
    end

    def package_file_name
      "#{@config["package"]["filename"]}.zip"
    end
  end
end
