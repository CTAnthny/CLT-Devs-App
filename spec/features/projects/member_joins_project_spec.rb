
feature "member joins project:" do
  let(:member) { FactoryBot.create(:member) }
  let!(:project) { FactoryBot.create(:project_with_tasks) }

  # As an authenticated user
	# I want to join a project
	# So that I can contribute
  #
  # Acceptance Criteria:
  #  [ ] -  I must be signed in
  #  [ ] -  I am able to click a link to join from the project details page
  #  [ ] -  I am notified of success and redirected to the project details page
  #  [ ] -  I am able to view my account name as a contributing member to the project

  context "member is authenticated:" do
    before(:each) do
      sign_in(member)
      visit projects_path
      click_link "#{project.name}"
    end

    scenario "member successfully joins project" do
      save_and_open_page
      click_link "Join Project"
      expect(page).to have_content("You have successfully joined the #{project.name} project!")
      expect(page).to have_current_path(project_path(project))
      expect(page).to have_content("Current Members: #{print_member.member.id}")
    end
  end
end
