require 'spec_helper'
feature "deleting projects" do
  before do
    sign_in_as!(Factory(:admin_user))
  end
	scenario "Deleteing a project" do
		Factory(:project, :name => "TextMate 2")
		visit '/'
		click_link "TextMate 2"
		click_link "Delete Project"
		page.should have_content("Project has been deleted.")

		visit '/'
		page.should_not have_content("TexteMate 2")
	end
end