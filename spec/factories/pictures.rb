FactoryGirl.define do
  factory :picture do
    monument
    sequence(:name) { |n| "Picture ##{n}" }
    description "Another picture of Lenin"
  end
end
