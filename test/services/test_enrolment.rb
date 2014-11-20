require 'test_helper'
require 'moodle/services/enrolment'

class EnrolmentTest < MiniTest::Test
  describe '#enrol_manual_enrol_user' do
    before do
      @client = Moodle.new(
        :token => 'b31dde13bade28f25d548a31fa994816',
        :protocol => 'rest',
        :domain => 'http://mydomain/moodle',
        :service => 'myservice',
        :format => 'json'
      )

      @options = { user_id: 1, role_id: 2, course_id: 3 }
    end

    it 'should return hash' do
    end
  end
end
