module ProjectApp
  module Projects
    module EventHandlers
      class UserUpdatedProject < RailsEventStore::Event
        def call(event)
          update_project(event.data)
        end

        private

        def update_project(data)
          params = data[:params]
          ProjectApp::Projects::Repository::Commands.update_project(params: params)
        end
      end
    end
  end
end
