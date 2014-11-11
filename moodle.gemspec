Gem::Specification.new do |spec|
  spec.name        = 'moodle'
  spec.version     = '0.1.0'
  spec.date        = '2014-03-01'
  spec.summary     = "Moodle web services from ruby"
  spec.description = "Interact with Moodle from ruby"
  spec.authors     = ["Robert Boloc"]
  spec.email       = 'robertboloc@gmail.com'
  spec.files       = `git ls-files`.split("\n")
  spec.homepage    =
    'http://robertboloc.github.com/moodle'
  spec.license     = 'MIT'
  
  spec.add_dependency('rest-client', '~> 1.7.2')
  spec.add_dependency('hashie', '> 3.3.0')

  spec.add_development_dependency('minitest')
  spec.add_development_dependency('minitest-matchers')
end
