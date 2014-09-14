FactoryGirl.define do
  factory :picture do
    monument
    sequence(:name) { |n| "Picture ##{n}" }
    description "Another picture of Lenin"
    picture { File.new(Rails.root.join("spec", "fixtures", "liberty.jpeg")) }
  end
end
