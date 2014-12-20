require 'rails_helper'

describe User, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  it 'validate_presence_of nickname' do is_expected.to validate_presence_of(:nickname) end
  it 'is invalid without nickname' do
    expect(FactoryGirl.build(:user, nickname: nil)).to_not be_valid
  end
  it 'validate_presence_of password' do is_expected.to validate_presence_of(:password) end
  it 'is invalid without password' do
    expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
  end
  it 'validate_presence_of email' do is_expected.to validate_presence_of(:email) end
  it 'is invalid without email' do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end
  it 'have many discussions' do is_expected.to have_many(:discussions) end
  it 'have many comments' do  is_expected.to have_many(:comments) end

end
