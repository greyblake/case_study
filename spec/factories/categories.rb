FactoryGirl.define do
  factory :category do
    user
    sequence(:name) { |n| "Category ##{n}" }
  end
end
