require 'faker'

FactoryGirl.define do
  factory :user do
    nickname Faker::Internet.user_name
    password Faker::Internet.password(8)
    email Faker::Internet.email
  end
end