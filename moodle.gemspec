$:.push File.expand_path("../lib", __FILE__)
# Maintain your gem's version:
require "moodle/version"
Gem::Specification.new do |spec|
  spec.name        = 'moodle'
  spec.version     = Moodle::VERSION
  spec.date        = '2014-11-11'
  spec.summary     = "Moodle web services from ruby"
  spec.description = "Interact with Moodle from ruby"
  spec.authors     = ["Robert Boloc"]
  spec.email       = 'robertboloc@gmail.com'
  spec.files       = `git ls-files`.split("\n")
  spec.homepage    = 'http://robertboloc.github.com/moodle'
  spec.license     = 'MIT'

  spec.required_ruby_version = '~> 2.0'
  
  spec.add_dependency('rest-client', '~> 1.7.2')
  spec.add_dependency('hashie', '> 3.3.0')
end
