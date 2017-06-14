module BeanstalkDeploy
  class Credentials
    def self.setup
      unless credentials.nil?
        Aws.config.update(credentials)
        aws_creds = Aws::Credentials.new(credentials["access_key_id"], credentials["secret_access_key"])
        Aws.config.update(region: region, credentials: aws_creds)
        return true
      end
      false
    end

    def self.credentials_username
      credentials
      @username = Aws::IAM::Client.new.get_user[:user][:user_name].capitalize if @username.nil?
      @username
    end

    def self.credentials
      @credentials = YAML::load_file(aws_secrets_file) if @credentials.nil?
      @credentials
    end

    def self.aws_secrets_file
      File.expand_path("~/.aws/contently.yml")
    end

    def self.region
      "us-east-1"
    end
  end
end
