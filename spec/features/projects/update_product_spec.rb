
feature "member updates an project" do
  let(:member) { FactoryBot.create(:member) }
  let!(:project) { FactoryBot.create(:project) }

  # As an authenticated and authorized member
  # I want to update a project's information
  # So that I can correct errors or provide new information
  #
  # # Acceptance Criteria:
  # [ ] - I must be logged in and authorized to edit project
  # [ ] - I am able to edit project details
  # [ ] - I am presented with errors if I fill out the form incorrectly
  # [ ] - I can reach the edit page from the details page
  # [ ] - After editing I am notified and returned to the show page
  # [ ] - Unauthorized users are unable to edit project details

  context "member is authenticated" do
    before(:each) do
      sign_in(member)
      visit projects_path
      click_link "#{project.name}"
      click_link "Edit Project"
    end

    scenario "member is logged in and authorized to edit project"

    scenario "member can reach the edit page from details" do
      expect(page).to have_current_path(edit_project_path(project))
    end

    scenario "member provides valid information and is returned to the show page" do
      fill_in 'Name', with: 'Draft code of conduct'
      fill_in 'Description', with: 'write up a bunch of rules'
      click_button "Submit"
      expect(page).to have_content("Your project has been successfully updated!")
      expect(page).to have_current_path(project_path(project))
    end

    scenario "member is presented with errors for invalid information" do
      fill_in 'Name', with: ''
      fill_in 'Description', with: ''
      click_button "Submit"
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Name is too short")
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_current_path(project_path(project))
    end
  end

  context "member is not authenticated" do
    scenario "member cannot update project" do
      sign_out(member)
      visit edit_project_path(project)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).to_not have_content('Project1')
      expect(page).to_not have_content('John Smith')
    end
  end
end
