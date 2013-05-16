require 'spec_helper'

feature "hidden links" do
  let(:user) {Factory(:confirmed_user)}
  let(:admin) {Factory(:admin_user)}
  let(:project) {Factory(:project)}

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
  end
end
