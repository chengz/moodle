require 'moodle/services/user'
require 'moodle/services/enrolment'
require 'moodle/services/course'
require 'moodle/services/cohort'
require 'moodle/services/webservice'
require 'rest_client'
require 'hashie'
require 'json'

module Moodle
  class Client
    include Moodle::Service::User
    include Moodle::Service::Enrolment
    include Moodle::Service::Course
    include Moodle::Service::Cohort
    include Moodle::Service::Webservice

    attr_reader :username, :password, :domain, :protocol, :service, :format, :token

    def initialize(options={})
      @username = options[:username] || Moodle.config[:username]
      @password = options[:password] || Moodle.config[:password]
      @domain   = options[:domain]   || Moodle.config[:domain]
      @protocol = options[:protocol] || Moodle.config[:protocol]
      @service  = options[:service]  || Moodle.config[:service]
      @format   = options[:format]   || Moodle.config[:format]
      @token    = options[:token]    || Moodle.config[:token]

      # If no token is provided generate one
      if @token.nil?
        @token = self.obtain_token
      end
    end

    # Obtains a token from the username and password
    def obtain_token
      response = RestClient.get(@domain + '/login/token.php', {
        :username => @username,
        :password => @password,
        :service  => @service
      })

      parsed = JSON.parse(response)
      parsed['token']
    end

    # Make a request using the desired protocol and format
    def request(method: :get, params: {})
      params.merge!(
        :wstoken => @token,
        :moodlewsrestformat => @format,
        :wsfunction => caller[0][/`.*'/][1..-2]
      )
      service_url = @domain + '/webservice/' + @protocol + '/server.php'
      if method == :post
        response = RestClient.post service_url, params
      elsif method == :delete
        response = RestClient.delete service_url, params
      else
        response = RestClient.get service_url, params: params
      end
      parse_response(response)
    end

    def parse_response(response)
      # moodle will return weird 'null' string
      JSON.parse(response) if !response.blank? && response != 'null'
    end
  end
end
