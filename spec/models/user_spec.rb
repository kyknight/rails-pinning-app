require 'spec_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do


  describe "User authenticate method" do

    before(:all) do
      @user = User.create!(first_name: "Kate", last_name: "Skillgal", email: "coder@skillcrush.com", password: "secret")
    end

    after(:all) do
      if !@user.destroyed?
        @user.destroy
      end
    end

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    it 'authenticates and returns a user when valid email and password passed in' do
      authenticate_user = User.authenticate(@user.email,@user.password)
      expect(authenticate_user).to eql(@user)
    end
  end


end