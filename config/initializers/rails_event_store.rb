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
  event_store.subscribe(
    ::ProjectApp::Tasks::EventHandlers::UserCreatedTask.new,
    to: [::ProjectApp::Tasks::Events::UserCreatedTask],
  )
  event_store.subscribe(
    ::ProjectApp::Tasks::EventHandlers::UserUpdatedTask.new,
    to: [::ProjectApp::Tasks::Events::UserUpdatedTask],
  )
  event_store.subscribe(
    ::ProjectApp::Tasks::EventHandlers::UserDeletedTask.new,
    to: [::ProjectApp::Tasks::Events::UserDeletedTask],
  )
end
