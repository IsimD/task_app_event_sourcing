module ProjectApp
  module Tasks
    module Repository
      class Commands
        class << self
          def create_task(params:)
            Task.create!(params)
          end

          def update_task(params:)
            Task.update(params[:id], params)
          end

          def delete_task(params:)
            Task.destroy(params[:id])
          end
        end
      end
    end
  end
end
