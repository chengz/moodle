require 'moodle/client'
require 'yaml'

module Moodle
  @@config = {
    :username => nil,
    :password => nil,
    :token => nil,
    :protocol => nil,
    :domain => nil,
    :service => nil,
    :format => 'json'
  }

  @valid_config_keys = @@config.keys

  # Configuration is for the instance only
  def self.new(options={})
    Moodle::Client.new(options)
  end

  # Configure at global level trough hash
  def self.configure(options={})
    options.each {|k,v| @@config[k.to_sym] = v if @valid_config_keys.include? k.to_sym}
  end

  # Configure at global level through yaml file
  def self.configure_with(path_to_yaml_file)
    config = YAML::load(IO.read(path_to_yaml_file))
    configure(config)
  end

  # Obtain the global configuration
  def self.config
    @@config
  end
end
