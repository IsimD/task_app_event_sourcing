module API
  module V1
    module Defaults
      NoAuthorizationError = Class.new(StandardError)
      extend ActiveSupport::Concern

      included do
        prefix 'api'
        version 'v1', using: :path
        default_format :json
        format :json

        helpers do
          def authenticate_token
            authenticate_with_http_token do |token|
              User.find_by(auth_token: token)
            end
          end

          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def logger
            Rails.logger
          end

          def current_user
            @current_user ||= authenticate_token
          end

          def authenticate_user!
            raise NoAuthorizationError unless current_user
          end
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end
      end
    end
  end
end
