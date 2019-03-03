module ProjectApp
  module Projects
    module UseCases
      class UserCreateProject
        class << self
          def call(params:, user:)
            create_event(user, params)
          end

          private

          def create_event(user, params)
            stream_name = "user_$#{user.id}"
            second_steam_name = "project_$#{params[:id]}"
            event = ProjectApp::Projects::Events::UserCreatedProject.new(
              data: {
                user_id: user.id,
                params: params
              }
            )
            event_store.publish(event, stream_name: stream_name)
            event_store.link(event.event_id, stream_name: second_steam_name)
          end

          def event_store
            Rails.configuration.event_store
          end
        end
      end
    end
  end
end
