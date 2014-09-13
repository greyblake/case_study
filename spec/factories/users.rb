FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "john_#{n}" }
    password '12345678'
  end
end
