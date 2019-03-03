module API
  module V1
    class Tasks < Grape::API
      include API::V1::Defaults

      resource :tasks do
        desc 'Create task'
        params do
          requires  :id,          type: String
          requires  :project_id,  type: String
          requires  :name,        type: String
          optional  :description, type: String
        end

        post do
          ::ProjectApp::Tasks::UseCases::UserCreateTask.call(
            user: current_user,
            params: permitted_params
          )
          { message: 'OK' }
        end

        desc 'Update project'
        params do
          requires  :id,          type: String
          requires  :name,        type: String
          optional  :description, type: String
        end

        put '/:id' do
          ::ProjectApp::Tasks::UseCases::UserUpdateTask.call(
            user: current_user,
            params: permitted_params
          )
          { message: 'OK' }
        end
      end
    end
  end
end
