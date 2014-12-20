require 'faker'

FactoryGirl.define do
  factory :discussion do
    title {Faker::Lorem.sentence(3)}
    description {Faker::Lorem.paragraph(2, true, 4)}
    association :user, factory: :user
  end
end