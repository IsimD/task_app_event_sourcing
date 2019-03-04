module ProjectApp
  module TimeTracking
    module Repository
      class Queries
        class << self
          def not_finished_time_point_for_task(task_id:, user_id:)
            TimeTrackingPoint.where(user_id: user_id, task_id: task_id, stop_time: nil)
          end

          def find_task(task_id:)
            Task.find(task_id)
          end

          def find_project_for_task(task:)
            task.project
          end

          def find_project_time_tracked(project:)
            project.project_time_tracked
          end

          def find_task_time_tracked(task:)
            task.task_time_tracked
          end
        end
      end
    end
  end
end
