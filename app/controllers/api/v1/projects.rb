module API
  module V1
    class Projects < Grape::API
      include API::V1::Defaults

      resource :projects do
        desc ''
        params do
        end
        post  do
          { message: 'OK' }
        end
      end
    end
  end
end
