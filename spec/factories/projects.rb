FactoryBot.define do
  factory :project do
    id           { SecureRandom.hex }
    name         { Faker::Restaurant.name }
    description  { Faker::Lorem.sentence }
  end
end
