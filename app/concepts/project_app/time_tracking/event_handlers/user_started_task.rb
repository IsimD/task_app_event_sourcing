module ProjectApp
  module TimeTracking
    module EventHandlers
      class UserStartedTask
        def call(event)
          create_time_tracking_point(event.data)
        end

        private

        def create_time_tracking_point(data)
          id = SecureRandom.hex
          params = data[:params]
          params[:id] = id
          user_id = data[:user_id]
          ProjectApp::TimeTracking::Repository::Commands.create_time_tracking_point(
            params: params,
            user_id: user_id
          )
        end
      end
    end
  end
end
