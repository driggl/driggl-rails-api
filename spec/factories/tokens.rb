FactoryGirl.define do
  factory :token do
    sequence(:token) { |n| n.to_s }
    expires_at "2017-07-30 15:49:22"
    association :user
  end
end
