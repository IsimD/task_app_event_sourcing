FactoryBot.define do
  factory :task_time_tracked do
    id           { SecureRandom.hex }
    task_id      { SecureRandom.hex }
    time_tracked { Faker::Number.decimal(2) }
  end
end
