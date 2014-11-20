require 'test_helper'
require 'moodle/services/course'

class CourseTest < MiniTest::Test
  describe '#core_course_get_courses' do
    before do
      @client = Moodle.new(
        :token => 'b31dde13bade28f25d548a31fa994816',
        :protocol => 'rest',
        :domain => 'http://mydomain/moodle',
        :service => 'myservice',
        :format => 'json'
      )

      @options = { ids: [1,2,3] }
      @body = [{categoryid: 2, categorysortorder: 20003, name: 'Test', timecreated: 1408503118, timemodified: 1411968817, visible: 1,
        fullname: "Transfield Food Handlers Course"}]
    end

    it 'should return hash' do
      Moodle::Client.any_instance.stubs(:request).returns(@body)
      expected = [Hashie::Mash.new(@body.first)]
      @client.core_course_get_courses(@options).must_equal expected
    end

    it 'should return error if ids not provided' do
      lambda{ @client.core_course_get_courses(nil) }.
        must_raise(NoMethodError)
    end
  end
end
