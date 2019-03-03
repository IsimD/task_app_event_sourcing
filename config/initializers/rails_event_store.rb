Rails.configuration.to_prepare do
  Rails.configuration.event_store = event_store = RailsEventStore::Client.new
  event_store.subscribe(
    ::ProjectApp::Projects::EventHandlers::UserCreatedProject.new,
    to: [::ProjectApp::Projects::Events::UserCreatedProject],
  )
  event_store.subscribe(
    ::ProjectApp::Projects::EventHandlers::UserUpdatedProject.new,
    to: [::ProjectApp::Projects::Events::UserUpdatedProject],
  )
  event_store.subscribe(
    ::ProjectApp::Projects::EventHandlers::UserDeletedProject.new,
    to: [::ProjectApp::Projects::Events::UserDeletedProject],
  )
end
