require 'rails_helper'

describe Comment, type: :model do
  let (:user) { User.first || FactoryGirl.create(:user)}
  let (:discussion) { FactoryGirl.create(:discussion, user: user) }
  it 'has a valid factory' do
    expect(FactoryGirl.build(:comment, user: user, discussion: discussion)).to be_valid
  end

  it 'belongs to user' do is_expected.to belong_to(:user) end
  it 'belongs to discussion' do  is_expected.to belong_to(:discussion) end



end
