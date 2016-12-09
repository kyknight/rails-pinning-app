require 'spec_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
      @user = FactoryGirl.create(:user)
      @pins = @user.pins
  end

  it "renders attributes in <p>" do
    render
    @user.pins.each do |pin|
    	expect(rendered).to match(@user.first_name)
    	expect(rendered).to match(@user.last_name)
    	expect(rendered).to match(@user.email)
    	expect(rendered).to match(pin.title)
    end
  end
end