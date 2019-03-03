module ProjectApp
  module Tasks
    module EventHandlers
      class UserDeletedTask < RailsEventStore::Event
        def call(event)
          delete_task(event.data)
        end

        private

        def delete_task(data)
          params = data[:params]
          ProjectApp::Tasks::Repository::Commands.delete_task(params: params)
        end
      end
    end
  end
end
