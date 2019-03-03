FactoryBot.define do
  factory :project do
    name         { Faker::Lorem.words }
    description  { Faker::Lorem.sentence }
  end
end
