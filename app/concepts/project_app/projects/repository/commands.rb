module ProjectApp
  module Projects
    module Repository
      class Commands
        class << self
          def create_project(params:)
            Project.create!(params)
          end

          def update_project(params:)
            Project.update(params[:id], params)
          end

          def delete_project(params:)
            Project.destroy(params[:id])
          end
        end
      end
    end
  end
end
