require 'rails_helper'

RSpec.describe Member, type: :model do
  context "first name" do
    it { should validate_presence_of(:first_name) }
    it { should have_valid(:first_name).when('John', 'Sally') }
    it { should_not have_valid(:first_name).when(nil, '') }
  end

  context "last name" do
    it { should validate_presence_of(:last_name) }
    it { should have_valid(:last_name).when('Smith', 'Swanson') }
    it { should_not have_valid(:last_name).when(nil, '') }
  end

  context "email" do
    it { should have_valid(:email).when('user@example.com', 'another@gmail.com') }
    it { should_not have_valid(:email).when(nil, '', 'urser', 'usersba.com') }
    it { should validate_presence_of(:email) }
  end

  context "password" do
    it 'has a matching password confirmation' do
      user = Member.new
      user.password = 'password'
      user.password_confirmation = 'anotherpassword'

      expect(user).to_not be_valid
      expect(user.errors[:password_confirmation]).to_not be_blank
    end
  end

  context "interests" do

  end

  context "skills" do

  end
end
