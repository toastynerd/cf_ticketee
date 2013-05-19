require 'spec_helper'

feature 'signing up' do
  scenario "successfully sign up" do
    visit '/'
    click_link 'Sign up'
    fill_in "Email", :with => "user@ticketee.com"
    fill_in "Password", :with => "foobar"
    fill_in "Password confirmation", :with => "foobar"

    click_button "Sign up"
    message = "Please open the link to activate your account."
    page.should have_content("Please confirm your account before signing in.")
  end
end
