module ProjectApp
  module TimeTracking
    module EventHandlers
      class UserStoppedTask
        def call(event)
          stop_time   = event.data[:params][:stop_time]
          time_change = event.data[:params][:time_change]
          task = find_task(event.data[:params][:task_id])
          time_tracking_point = find_time_tracking_point(task)

          run_db_transation(task, time_tracking_point, stop_time, time_change)
        end

        private

        def run_db_transation(task, time_tracking_point, stop_time, time_change)
          ActiveRecord::Base.transaction do
            update_time_tracking_point(time_tracking_point, stop_time)
            upsert_time_for_task(task, time_change)
            upsert_time_for_project(task, time_change)
          end
        end

        def find_task(task_id)
          ProjectApp::TimeTracking::Repository::Queries.find_task(
            task_id: task_id
          )
        end

        def find_time_tracking_point(task)
          task.time_tracking_points.where(stop_time: nil).first
        end

        def update_time_tracking_point(time_tracking_point, stop_time)
          ProjectApp::TimeTracking::Repository::Commands.update_stop_time_for_time_tracking_point(
            time_tracking_point: time_tracking_point,
            stop_time: stop_time
          )
        end

        def upsert_time_for_task(task, time_change)
          task_time_tracked = ProjectApp::TimeTracking::Repository::Queries
                              .find_task_time_tracked(task: task)
          if task_time_tracked
            ProjectApp::TimeTracking::Repository::Commands.update_time_for_task_time_tracked(
              task_time_tracked: task_time_tracked,
              time_change: time_change
            )
          else
            ProjectApp::TimeTracking::Repository::Commands.create_time_tracked_for_task(
              task: task,
              time_change: time_change
            )
          end
        end

        def upsert_time_for_project(task, time_change)
          project = ProjectApp::TimeTracking::Repository::Queries
                    .find_project_for_task(task: task)
          project_time_tracked = ProjectApp::TimeTracking::Repository::Queries
                                 .find_project_time_tracked(project: project)

          if project_time_tracked
            ProjectApp::TimeTracking::Repository::Commands.update_time_for_project_time_tracked(
              project_time_tracked: project_time_tracked,
              time_change: time_change
            )
          else
            ProjectApp::TimeTracking::Repository::Commands.create_time_tracked_for_project(
              project: project,
              time_change: time_change
            )
          end
        end
      end
    end
  end
end
