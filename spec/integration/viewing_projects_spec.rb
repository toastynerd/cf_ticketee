require 'spec_helper'

feature "Viewing Projects" do
	scenario "Listing all the projects" do
		project = Factory.create(:project, :name=> "TextMate 2")		
		visit '/'
		click_link 'TextMate 2'
		page.current_url.should == project_url(project)
	end
end

