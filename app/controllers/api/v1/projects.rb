module API
  module V1
    class Projects < Grape::API
      include API::V1::Defaults

      resource :projects do
        desc 'Create project'
        params do
          requires  :id,          type: String
          requires  :name,        type: String
          optional  :description, type: String
        end

        post do
          ::ProjectApp::Projects::UseCases::UserCreateProject.call(
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
          ::ProjectApp::Projects::UseCases::UserUpdateProject.call(
            user: current_user,
            params: permitted_params
          )
          { message: 'OK' }
        end

        desc 'Destroy project'
        params do
          requires :id, type: String
        end

        delete '/:id' do
          ::ProjectApp::Projects::UseCases::UserDeleteProject.call(
            user: current_user,
            params: permitted_params
          )
          { message: 'OK' }
        end
      end
    end
  end
end
