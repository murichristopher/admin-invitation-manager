FactoryBot.define do
  factory :invitation do
    active        { true }
    association :company
    association :user
  end
end