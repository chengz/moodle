module Moodle
  module Service
    module User
      # Get users by field
      def core_user_get_users_by_field(field, values)
        params = {
          :field => field
        }

        # Add all the userids as array params
        counter = 0
        values.each do |id|
          params['values[' + counter.to_s + ']'] = id
          counter += 1
        end

        response = request(params: params)
        Hashie::Mash.new(*response)
      end

      # Search for users matching the criteria
      def core_user_get_users(criteria)
        params = {}

        counter = 0
        criteria.each do |key,value|
          params['criteria[' + counter.to_s + '][key]'] = key.to_s
          params['criteria[' + counter.to_s + '][value]'] = value
          counter += 1
        end

        response = request(params: params)

        if response['users']
          response['users'].map { |user| Hashie::Mash.new(user) }
        end
      end

      def core_user_create_user(user)
        core_user_create_users([user])
      end

      def core_user_create_users(users = [])
        response = request(method: :post, params: process_users(users))
        response.map { |user| Hashie::Mash.new(user) }
      end

      def core_user_update_user(user)
        core_user_update_users([user])
      end

      def core_user_update_users(users = [])
        response = request(method: :post, params: process_users(users))
        response ||= users
        response.map { |user| Hashie::Mash.new(user) }
      end

      protected
        def process_users(users)
          counter = 0
          params = {}
          users.each do |user|
            user.each do |key, value|
              hash_key = 'users[' + counter.to_s + '][' + key.to_s + ']'
              if value.is_a?(Hash)
                index = 0
                value.each do |subkey, subvalue|
                  sub_hash_key = hash_key + '[' + index.to_s + ']'
                  params[sub_hash_key + '[type]'] = subkey.to_s
                  params[sub_hash_key + '[value]'] = subvalue
                  index += 1
                end
              else
                params[hash_key] = value
              end
            end
            counter += 1
          end
          params
        end
    end
  end
end
