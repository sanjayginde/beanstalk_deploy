# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beanstalk_deploy/version'

Gem::Specification.new do |spec|
  spec.name          = "beanstalk_deploy"
  spec.version       = BeanstalkDeploy::VERSION
  spec.authors       = ["Sanjay Ginde"]
  spec.email         = ["sanjay@contently.com"]

  spec.summary       = %q{Elastic beanstalk deployment wrapper}
  spec.description   = %q{Wraps all the things.}
  spec.homepage      = "http://github.com/contently/beanstalk_deploy"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = "beanstalk_deploy"
  spec.require_paths = ["lib"]

  # spec.files         = `git ls-files -z`.split("\x0").reject do |f|
  #   f.match(%r{^(test|spec|features)/})
  # end
  # spec.bindir        = "exe"
  # spec.executables   = "deploy"
  # spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "aws-sdk", ">= 2.1"
  spec.add_runtime_dependency "eb_deployer", ">= 0.6.3"
  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "table_print"
  spec.add_runtime_dependency "activesupport"
end
