require 'spec_helper'

feature "creating users" do
  let!(:admin) {Factory(:admin_user)}
  before do
    sign_in_as!(admin)
    visit '/'
    click_link "Admin"
    click_link "Users"
    click_link "New User"
  end

  scenario "creating a new user" do
    fill_in "Email", :with => "noob@exampe.com"
    fill_in "Password", :with => "foobar"
    click_button "Create User"
    page.should have_content("User has been created.")
  end

  scenario "Leaving email blank results in an error" do
    fill_in "Email", :with => ""
    fill_in "Password", :with => "foobar"
    click_button "Create User"
    page.should have_content("User has not been created.")
    page.should have_content("Email can't be blank")
  end
end