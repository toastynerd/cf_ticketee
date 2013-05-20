require 'spec_helper'

feature "hidden links" do
  let(:user) {Factory(:confirmed_user)}
  let(:admin) {Factory(:admin_user)}
  let(:project) {Factory(:project)}
  let!(:ticket) {Factory(:ticket, :project => project, :user => user)}

  context "anonymous users" do
    scenario "cannot see the new project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "cannot see the edit link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the delete link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end

  context "regular users" do
    before {sign_in_as!(user)}
    scenario "cannot see the new project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "cannot see the edit link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the delete link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end

    scenario "new ticket link is shown to a user with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "create tickets", project)
      visit project_path(project)
      assert_link_for "New Ticket"
    end

    scenario "new ticket link is hiddn from a user with permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      assert_no_link_for "New Ticket"
    end

    scenario "edit ticket link is shown to a user with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "edit tickets", project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end

    scenario "edit ticket link is now shown to a user without permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Edit Ticket"
    end

    scenario "delete ticket link is show to a user with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "delete tickets", project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Delete Ticket"
    end

    scenario "Dlete ticket link is hidden for a user without permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Delete Ticket"
    end

  end

  context "admin users" do
    before {sign_in_as!(admin)}
    scenario "can see a new project link" do
      visit '/'
      assert_link_for "New Project"
    end

    scenario "can see an edit project link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end

    scenario "can see the delete project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end

    scenario "new ticket link is shown to admins" do
      visit project_path(project)
      assert_link_for "New Ticket"
    end

    scenario "edit ticket link is shown to admins" do
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end

    scenario "delete ticket link is shown to admins" do
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Delete Ticket"
    end
  end
end
