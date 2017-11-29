
feature "member reviews item:" do
  let(:member) { FactoryBot.create(:member) }
  let!(:project) { FactoryBot.create(:project) }

  # As an authenticated member
  # I want to add a task
  # So that others can view it
  #
  # Acceptance Criteria:
  #  [X] - I must be signed in to create a task
  #  [X] - I must be on the project detail page
  #  [X] - A task title and description is required
  #  [X] - Task deadline, keywords, needs, and member assignments are optional
  #  [X] - I am presented with errors and the task is not created if I fill out the form incorrectly
  #  [X] - Member is redirected to project detail page after creation

  context "member is authenticated:" do
    before(:each) do
      sign_in(member)
      visit projects_path
      click_link "#{project.name}"
      click_link "Add New Task"
    end

    scenario "member visits project detail page and successfully creates task" do
      description = "Lorem Ipsum is the industry's standard dummy text."
      fill_in "Description", with: description
      fill_in "Name", with: "Create Navbar"
      click_button "Submit"

      expect(page).to have_current_path(project_path(project))
      expect(page).to have_content("Your task has been successfully created!")
      expect(page).to have_content("Create Navbar")
      expect(page).to have_content(description)
    end

    scenario "member submits invalid information" do
      fill_in "Name", with: ""
      fill_in "Description", with: ""
      click_button "Submit"
      expect(page).to_not have_content("Your task has been successfully created!")
      expect(page).to have_content("Namecan't be blank and is too short (minimum is 3 characters)")
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "member is not authenticated:" do
    scenario "member cannot add a review" do
      sign_out(member)
      visit project_path(project)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
