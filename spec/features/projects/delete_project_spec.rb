
feature "member deletes an project" do
  let!(:member) { FactoryBot.create(:member) }
  let!(:project) { FactoryBot.create(:project) }

  # As an authenticated and authorized member
  # I want to delete a project
  # So that no one can view it
  #
  # # Acceptance Criteria:
  #  [X] - I must be logged in and authorized to delete projects
  #  [X] - I must be able to delete a project from the edit page
  #  [X] - I must be able to delete a project from the details page
  #  [ ] - All tasks associated with the project must also be deleted
  #  [X] - After deleting I am notified and returned to the index page
  #  [ ] - Unauthorized members are unable to delete projects

  context "member is authenticated" do
    before(:each) do
      sign_in(member)
      visit projects_path
      click_link "#{project.name}"
    end

    scenario "member is logged in and authorized to delete projects"

    scenario "member is able to delete a project from the edit page" do
      click_link "Edit Project"
      click_link "Delete Project"
      expect(page).to have_content('Your project has been successfully deleted!')
    end

    scenario "member is able to delete a project from the show page" do
      click_link "Delete Project"
      expect(page).to have_content('Your project has been successfully deleted!')
    end

    scenario "after successful deletion the member is notified and directed to index" do
      click_link "Delete Project"
      expect(page).to have_content('Your project has been successfully deleted!')
      expect(page).to have_current_path(projects_path)

      expect(page).to_not have_content("#{project.name}")
    end

    scenario "all tasks associated with the project are deleted"
  end

  context "member is not authenticated" do
    scenario "member cannot delete projects"
  end
end
