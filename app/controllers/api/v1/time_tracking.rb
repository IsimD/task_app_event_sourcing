module API
  module V1
    class TimeTracking < Grape::API
      include API::V1::Defaults

      resource :time_tracking do
        desc 'Start tracker'
        params do
          requires  :task_id,     type: String
          requires  :start_time,  type: String
        end

        post ':task_id/start' do
          ::ProjectApp::TimeTracking::UseCases::UserStartTask.call(
            user: current_user,
            params: permitted_params
          )
          { message: 'OK' }
        rescue ProjectApp::TimeTracking::UseCases::UserStartTask::TaskAlreadyStarted
          status 422
          { message: 'Task already started' }
        end

        desc 'Stop tracker'
        params do
          requires  :task_id, type: String
          requires  :stop_time, type: String
        end

        put ':task_id/stop' do
          ::ProjectApp::TimeTracking::UseCases::UserStopTask.call(
            user: current_user,
            params: permitted_params
          )
          { message: 'OK' }
        rescue ProjectApp::TimeTracking::UseCases::UserStopTask::TaskNotStarted
          status 422
          { message: 'Task not started' }
        end

        desc 'Edit tracker'
        params do
          requires  :task_id, type: String
          requires  :time_spend, type: String
        end
      end
    end
  end
end
