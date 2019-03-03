module ProjectApp
  module Projects
    module EventHandlers
      class UserDeletedProject < RailsEventStore::Event
        def call(event)
          delete_project(event.data)
        end

        private

        def delete_project(data)
          params = data[:params]
          ProjectApp::Projects::Repository::Commands.delete_project(params: params)
        end
      end
    end
  end
end
