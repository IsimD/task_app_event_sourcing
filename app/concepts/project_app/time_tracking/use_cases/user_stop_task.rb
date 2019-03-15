module ProjectApp
  module TimeTracking
    module UseCases
      class UserStopTask
        TaskNotStarted = Class.new(StandardError)
        class << self
          def call(params:, user:)
            time_tracking_point = find_time_tracking_point(params[:task_id], user.id)
            check_if_can_stop(time_tracking_point)
            time_change = calculate_time_change(time_tracking_point, params[:stop_time])
            prepared_params = prepare_params(params, time_change)

            create_event(user, prepared_params)
          end

          private

          def check_if_can_stop(time_tracking_point)
            raise TaskNotStarted unless check_if_task_already_started(time_tracking_point)
          end

          def prepare_params(params, time_change)
            params.merge(time_change: time_change)
          end

          def find_time_tracking_point(task_id, user_id)
            ProjectApp::TimeTracking::Repository::Queries.not_finished_time_point_for_task(
              task_id: task_id,
              user_id: user_id
            )
          end

          def calculate_time_change(time_tracking_point, stop_time)
            stop_time.to_time - time_tracking_point.start_time
          end

          def check_if_task_already_started(time_tracking_point)
            !time_tracking_point.nil?
          end

          def create_event(user, params)
            user_stream = "user_$#{user.id}"
            task_stream = "task_$#{params[:task_id]}"
            event = ProjectApp::TimeTracking::Events::UserStoppedTask.new(
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
