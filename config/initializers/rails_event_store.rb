Rails.configuration.to_prepare do
  Rails.configuration.event_store = event_store = RailsEventStore::Client.new
  event_store.subscribe(
    ::ProjectApp::Projects::EventHandlers::UserCreatedProject.new,
    to: [::ProjectApp::Projects::Events::UserCreatedProject],
  )
end
