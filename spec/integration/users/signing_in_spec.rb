require 'spec_helper'

feature "signing in" do
  before do
    Factory(:user, :email => "ticketee@example.com")
  end

  scenario "Signing in through e-mail confirmation" do
    open_email "ticketee@example.com", :with_subject => /Confirmation/
    click_first_link_in_email
    page.should have_content("Your account was successfully confirmed")
    page.should have_content("Signed in as ticketee@example.com")
  end

  scenario "Signing in through a form" do
    User.find_by_email('ticketee@example.com').confirm!
    visit '/'
    click_link "Sign in"
    fill_in 'Email', :with =>"ticketee@example.com"
    fill_in 'Password', :with => "foobar"
    click_button "Sign in"
    page.should have_content("Signed in successfully")
  end
end