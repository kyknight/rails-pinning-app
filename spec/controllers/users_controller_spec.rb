require 'spec_helper'
RSpec.describe UsersController, type: :controller do

  before(:each) do 
    @user = FactoryGirl.build(:user)
  end
  after(:each) do
    if !@user.destroyed?
      @user.destroy
    end
  end

let(:valid_attributes) {
  {
    first_name: @user.first_name,
    last_name: @user.last_name,
    email: @user.email,
    password: @user.password
  }
}
let(:invalid_attributes) {
  {
    first_name: @user.first_name,
    password: @user.password
  }
}

  

#text test
  describe "GET login" do
    it "renders the login view" do
      get('login')
      expect(response).to render_template("login")
    end
  end
 
  describe "POST login" do
 
    it "renders the show view if params valid" do
     user = User.create! valid_attributes
     post :authenticate, @valid_user_hash
     expect(response).to redirect_to(user_path(@user.id))
    end
 
    it "populates @user if params valid" do 
     user = User.create! valid_attributes
     post :authenticate, @valid_user_hash
     expect(@user.present?).to be(true)
    end
 
    it "renders the login view if params invalid" do
      user = User.create! valid_attributes
      post :authenticate, @invalid_user_hash
      expect(response).to render_template("login")     
   end
 
    it "populates the @errors variable if params invalid" do
      user = User.create! valid_attributes
      post :authenticate, @invalid_user_hash 
      expect(assigns[:errors].present?).to be(true)
    end
  end

end