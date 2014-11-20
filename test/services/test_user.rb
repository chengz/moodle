require 'test_helper'
require 'moodle/services/user'

class UserTest < MiniTest::Test
  describe '#core_user_get_users' do
    before do
      @client = Moodle.new(
        :token => 'b31dde13bade28f25d548a31fa994816',
        :protocol => 'rest',
        :domain => 'http://mydomain/moodle',
        :service => 'myservice',
        :format => 'json'
      )

      @options = { somekey: 'somevalue' }
      @body = [{ customfields: {name: 'State', shortname: 'state', type: 'menu', value: 'VIC'}, department: '', email: 'testdummy@test.com', firstaccess: 0, 
        firstname: 'Test', fullname: 'Test Dummy', id: 123, lastaccess: 0, lastname: 'Dummy', profileimageurl: 'test.png', profileimageurlsmall: 'test.png',
        username: 'test_dummy' }]
    end

    it 'should return hash' do
      Moodle::Client.any_instance.stubs(:request).returns({ 'users' => @body})
      expected = [Hashie::Mash.new(@body.first)]
      @client.core_user_get_users(@options).must_equal expected
    end

    it 'should return error' do
      lambda{ @client.core_user_get_users(nil) }.
        must_raise(NoMethodError)
    end
  end


  describe '#core_user_create_user' do
    before do
      @client = Moodle.new(
        :token => 'b31dde13bade28f25d548a31fa994816',
        :protocol => 'rest',
        :domain => 'http://mydomain/moodle',
        :service => 'myservice',
        :format => 'json'
      )

      @options = { username: 'test_dummy' }
    end

    it 'should return hash' do
      body = [{ id: 123, username: 'test_dummy'}]
      Moodle::Client.any_instance.stubs(:request).returns(body)
      @client.core_user_create_user(@options).must_equal [Hashie::Mash.new(body.first)]
    end

    it 'should return error' do
      lambda{ @client.core_user_create_user(nil) }.must_raise(NoMethodError)
    end
  end
end
