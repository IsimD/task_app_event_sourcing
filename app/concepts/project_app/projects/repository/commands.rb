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
        end
      end
    end
  end
end
