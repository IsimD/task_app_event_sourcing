module ProjectApp
  module Tasks
    module Repository
      class Commands
        class << self
          def create_task(params:)
            Task.create!(params)
          end
        end
      end
    end
  end
end
