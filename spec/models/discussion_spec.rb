require 'rails_helper'

describe Discussion, type: :model do
  let (:user) { User.first || FactoryGirl.create(:user)}
  it 'has a valid factory' do
    expect(FactoryGirl.build(:discussion, user: user)).to be_valid
  end
  it 'validate_presence_of title' do is_expected.to validate_presence_of(:title) end
  it 'validate_presence_of description' do is_expected.to validate_presence_of(:description) end

  it 'validate length of title' do is_expected.to validate_length_of(:title).is_at_least(3) end
  it 'validate length of description' do is_expected.to validate_length_of(:description).is_at_least(3) end

  it 'belongs to user' do is_expected.to belong_to(:user) end
  it 'have many comments' do  is_expected.to have_many(:comments) end



end
