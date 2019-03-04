module ProjectApp
  module TimeTracking
    module UseCases
      class UserStartTask
        TaskAlreadyStarted = Class.new(StandardError)
        class << self
          def call(params:, user:)
            check_if_can_start(params, user)
            create_event(user, params)
          end

          private

          def check_if_can_start(params, user)
            raise TaskAlreadyStarted if check_if_task_already_started(params[:task_id], user.id)
          end

          def check_if_task_already_started(task_id, user_id)
            ProjectApp::TimeTracking::Repository::Queries.not_finished_time_point_for_task(
              task_id: task_id,
              user_id: user_id
            ).any?
          end

          def create_event(user, params)
            user_stream = "user_$#{user.id}"
            task_stream = "task_$#{params[:task_id]}"
            event = ProjectApp::TimeTracking::Events::UserStartedTask.new(
              data: {
                user_id: user.id,
                params: params
              }
            )
            event_store.publish(event, stream_name: user_stream)
            event_store.link(event.event_id, stream_name: task_stream)
          end

          def event_store
            Rails.configuration.event_store
          end
        end
      end
    end
  end
end
