FactoryBot.define do
  factory :time_tracking_point do
    id           { SecureRandom.hex }
    task_id      { SecureRandom.hex }
    user_id      { SecureRandom.hex }
    start_time   { Faker::Time.between(2.days.ago, Date.today, :all) }
    stop_time    { Faker::Number.decimal(2) }
  end
end
