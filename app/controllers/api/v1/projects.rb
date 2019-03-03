module API
  module V1
    class Projects < Grape::API
      include API::V1::Defaults

      resource :projects do
        desc ''
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
      end
    end
  end
end
