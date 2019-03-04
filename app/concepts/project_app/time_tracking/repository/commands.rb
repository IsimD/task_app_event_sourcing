module ProjectApp
  module TimeTracking
    module Repository
      class Commands
        class << self
          def create_time_tracking_point(params:, user_id:)
            TimeTrackingPoint.create!(params.merge(user_id: user_id))
          end

          def update_stop_time_for_time_tracking_point(time_tracking_point:, stop_time:)
            time_tracking_point.update!(stop_time: stop_time)
          end

          def create_time_tracked_for_task(task:, time_change:)
            id = SecureRandom.hex
            task.create_task_time_tracked(time_tracked: time_change, id: id)
          end

          def create_time_tracked_for_project(project:, time_change:)
            id = SecureRandom.hex
            project.create_project_time_tracked(time_tracked: time_change, id: id)
          end

          def update_time_for_project_time_tracked(project_time_tracked:, time_change:)
            project_time_tracked.increment!(:time_tracked, time_change)
          end

          def update_time_for_task_time_tracked(task_time_tracked:, time_change:)
            task_time_tracked.increment!(:time_tracked, time_change)
          end
        end
      end
    end
  end
end
