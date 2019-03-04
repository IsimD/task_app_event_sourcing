FactoryBot.define do
  factory :project_time_tracked do
    id           { SecureRandom.hex }
    project_id   { SecureRandom.hex }
    time_tracked { Faker::Number.decimal(2) }
  end
end
