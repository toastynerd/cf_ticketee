require 'spec_helper'

feature "Viewing Tickets" do
  before do
    user = Factory(:user)
    textmate_2 = Factory(:project, :name => "TextMate 2")
    ticket = Factory(:ticket, :project => textmate_2,
      :title => "Make it shiny!", :description => "Gradients, starbursts, oh my!" )
    ticket.update_attribute(:user, user)
    ticket.user = user
    ticket.save
    internet_exlorer = Factory(:project, :name => "Internet Explorer")
    Factory(:ticket, :project => internet_exlorer,
      :title => "Standards compliance", :description => "It isn't a joke")
    visit '/'
  end

  scenario "Viewing tickets for a specified project" do
    click_link "TextMate 2"
    page.should have_content("Make it shiny!")
    page.should_not have_content("Standards compliance")

    click_link "Make it shiny!"
    within("#ticket h2") do
      page.should have_content("Make it shiny!")
    end

    page.should have_content("Gradients, starbursts, oh my!")
  end
end
