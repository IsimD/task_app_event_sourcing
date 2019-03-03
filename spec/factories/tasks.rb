FactoryBot.define do
  factory :task do
    id           { SecureRandom.hex }
    project_id   { SecureRandom.hex }
    name         { Faker::Restaurant.name }
    description  { Faker::Lorem.sentence }
  end
end
