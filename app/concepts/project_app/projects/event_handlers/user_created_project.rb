module ProjectApp
  module Projects
    module EventHandlers
      class UserCreatedProject < RailsEventStore::Event
        def call(event)
          create_project(event.data)
        end

        private

        def create_project(data)
          params = data[:params]
          ProjectApp::Projects::Repository::Commands.create_project(params: params)
        end
      end
    end
  end
end
