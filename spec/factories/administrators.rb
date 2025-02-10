FactoryBot.define do
  factory :administrator do
    name { "John Doe" }
    sequence(:email) { |n| "admin#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end