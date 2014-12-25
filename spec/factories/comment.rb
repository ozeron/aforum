require 'faker'

FactoryGirl.define do
  factory :comment do
    content {Faker::Lorem.sentence(3)}
    association :user, factory: :user
    association :discussion, factory: :discussion
  end
end