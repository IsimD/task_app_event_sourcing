module ProjectApp
  module Tasks
    module UseCases
      class UserUpdateTask
        class << self
          def call(params:, user:)
            create_event(user, params)
          end

          private

          def create_event(user, params)
            user_stream_name   = "user_$#{user.id}"
            task_steam_name    = "project_$#{params[:id]}"
            event = ProjectApp::Tasks::Events::UserUpdatedTask.new(
              data: {
                user_id: user.id,
                params: params
              }
            )
            event_store.publish(event, stream_name: user_stream_name)
            event_store.link(event.event_id, stream_name: task_steam_name)
          end

          def event_store
            Rails.configuration.event_store
          end
        end
      end
    end
  end
end
