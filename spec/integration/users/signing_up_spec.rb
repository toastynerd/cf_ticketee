require 'spec_helper'

feature 'signing up' do
  scenario "successfully sign up" do
    visit '/'
    click_link 'Sign up'
    fill_in "Email", :with => "user@ticketee.com"
    fill_in "Password", :with => "foobar"
    fill_in "Password confirmation", :with => "foobar"

    click_button "Sign up"
    page.should have_content("You have signed up successfully.")
  end
end
