

module BeanstalkDeploy
  require "active_support/core_ext/module"
  require "active_support/core_ext/string"
  require "beanstalk_deploy/version"
  require "beanstalk_deploy/config"
  require "beanstalk_deploy/credentials"
  require "beanstalk_deploy/application"
  require "beanstalk_deploy/environment"
  require "beanstalk_deploy/instance"
  require "beanstalk_deploy/printer"
  require "beanstalk_deploy/command/clobber"
  require "beanstalk_deploy/command/ssh"
  require "beanstalk_deploy/command/status"
  require "beanstalk_deploy/cli"
end
