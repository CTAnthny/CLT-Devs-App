
feature "member views the details of an item" do
  let(:member) { FactoryBot.create(:member) }
  let!(:project) { FactoryBot.create(:project) }

  # As an authenticated member
  # I want to view a list of projects
  # So that I can pick projects to join

  # Acceptance Criteria:
  # [ ] - I must be logged in to view items
  # [ ] - I must be able to get to this page from the projects index
  # [ ] - I must be able to see the project name, description, updated_at time, and creator

  context "member is authenticated" do
    before(:each) do
      sign_in(member)
      visit projects_path
    end

    scenario "member selects an item from the index to view" do
      click_link "#{project.name}"
      expect(page).to have_current_path(project_path(project))
      expect(page).to have_content("#{project.name}")
      expect(page).to have_content("Description: #{project.description}")
      expect(page).to have_content("Created By: John Smith")
      expect(page).to have_content("Last Updated At: #{project.updated_at}")
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
