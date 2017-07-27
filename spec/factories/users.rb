FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| n }
    sequence(:login) { |n| "jsmith#{n}" }
    name "John Smith"
    url "http://johnsmith.com"
    avatar_url "http://github.com/avatars/jsmith.jpg"
    provider "github"
  end
end
