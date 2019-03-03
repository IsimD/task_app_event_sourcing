module ProjectApp
  module Tasks
    module EventHandlers
      class UserUpdatedTask < RailsEventStore::Event
        def call(event)
          create_task(event.data)
        end

        private

        def create_task(data)
          params = data[:params]
          ProjectApp::Tasks::Repository::Commands.update_task(params: params)
        end
      end
    end
  end
end
