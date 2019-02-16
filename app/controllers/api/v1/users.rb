module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do
        desc ''
        params do
        end
        get '', root: :users do
          { message: '123' }
        end
      end
    end
  end
end
