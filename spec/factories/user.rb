FactoryBot.define do
  factory :user do
    email        { Faker::Internet.email }
    name         { Faker::Name.name }
    password     { Faker::Lorem.words }
    auth_token   { SecureRandom.hex }
  end
end
