
feature "member reviews item" do
  let(:member) { FactoryBot.create(:member) }
  let!(:project) { FactoryBot.create(:project) }

  # As an authenticated member
  # I want to add a task
  # So that others can view it
  #
  # Acceptance Criteria:
  #  [ ] - I must be signed in to create a task
  #  [ ] - I must be on the project detail page
  #  [ ] - A task title and description is required
  #  [ ] - Task deadline, keywords, needs, and member assignments are optional
  #  [ ] - I am presented with errors and the task is not created if I fill out the form incorrectly
  #  [ ] - Member is redirected to project detail page after creation

  context "member is authenticated" do
    before(:each) do
      sign_in(member)
      visit projects_path
      click_link "#{project.name}"
      click_link "Add New Task"
    end

    scenario "member visits project detail page and successfully creates task" do
      description = "Lorem Ipsum is the industry's standard dummy text."
      fill_in "Description", with: description
      fill_in "Title", with: "Create Navbar"
      click_button "Create Task"

      expect(page).to have_current_path(project_path(project))
      expect(page).to have_content("Your task was successfully created!")
      expect(page).to have_content("Create Navbar")
      expect(page).to have_content(description)
    end

    scenario "member submits invalid information" do
      fill_in "Title", with: ""
      fill_in "Description", with: ""
      click_button "Create Task"
      expect(page).to_not have_content("Your task was successfully created!")
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Description can't be blank and Description is too short (minimum is 10 characters)")
    end
  end

  context "member is not authenticated" do
    scenario "member cannot add a review" do
      sign_out(member)
      visit project_path(project)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end