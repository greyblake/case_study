FactoryGirl.define do
  factory :collection do
    user
    sequence(:name) { |n| "Collection ##{n}" }
  end
end
