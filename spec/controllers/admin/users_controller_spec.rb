require 'spec_helper'

describe Admin::UsersController do
  let(:admin) {Factory(:admin_user)}
  let(:user) {Factory(:confirmed_user)}

  context "standard users " do
    before {sign_in(:user, user)}

    it "should not be able to use the index action" do
      get 'index'
      response.should redirect_to('/')
      flash[:alert].should eql("You must be admin to do that.")
    end
  end

  context "admin users" do
    before {sign_in(:admin, admin)}

    it "should be able to use the index action" do
      get 'index'
      response.should have_content("")
    end
  end
end
