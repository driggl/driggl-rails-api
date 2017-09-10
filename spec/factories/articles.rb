FactoryGirl.define do
  factory :article do
    sequence(:title) { |n| "My awesome article #{n}" }
    sequence(:content) { |n| "Even better content #{n}" }
  end
end
