module Moodle
  module Service
    module Enrolment
      def enrol_manual_enrol_user(user_id: nil, role_id: nil, course_id: nil)
        enrolment = {
          userid: user_id,
          roleid: role_id,
          courseid: course_id
        }
        enrol_manual_enrol_users([enrolment])
      end

      def enrol_manual_enrol_users(enrolments)
        counter = 0
        params = {}
        enrolments.each do |enrolment|
          params['enrolments[' + counter.to_s + ']'] = enrolment
        end

        response = request(method: :post, params: params)
        response ||= enrolments
        
        if response.any?
          response.map { |enrolment| Hashie::Mash.new(enrolment) }
        end
      end
    end
  end
end

