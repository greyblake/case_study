FactoryGirl.define do
  factory :monument do
    collection
    category
    sequence(:name) { |n| "Monument ##{n}" }
    description "Another Lenin monument"
  end
end
