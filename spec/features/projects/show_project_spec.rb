
feature "member views the details of an item" do
  let(:member) { FactoryBot.create(:member) }
  let!(:project) { FactoryBot.create(:project) }

  # As an authenticated member
  # I want to view the details of a project
  # So that I can get more information about it

  # Acceptance Criteria:
  # [X] - I must be signed in
  # [X] - I must be able to get to this page from the projects index
  # [X] - I must be able to see the project name, description, updated_at time, and creator
  # [ ] - I must be able to view the project's git url
  # [ ] - I must be able to view the current members working on the project
  # [ ] - I must be able to view the project's tasks and associated members
  # [ ] - I must be able to view proposed deadlines
  # [ ] - I must be able to view a project's keywords and "desired" categories
  # [ ] - I am able to go back to the all projects index page

  context "member is authenticated" do
    before(:each) do
      sign_in(member)
      visit projects_path
    end

    scenario "member selects an item from the index to view" do
      click_link "#{project.name}"
      expect(page).to have_current_path(project_path(project))
      expect(page).to have_content("#{project.name}")
      expect(page).to have_content("#{project.description}")
      expect(page).to have_content("Created By: John Smith")
      expect(page).to have_content("Last Updated: #{project.updated_at.to_formatted_s(:long)}")
    end

    scenario "member views item rating and comments"
  end

  context "member is not authenticated" do
    scenario "member cannot view items" do
      sign_out(member)
      visit projects_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
