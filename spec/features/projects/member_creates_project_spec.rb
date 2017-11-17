
feature "member adds project:" do
  let(:member) { FactoryBot.create(:member) }
  after(:all) { Project.delete_all; Member.delete_all }

  # As an authenticated member
  # I want to add a project
  # So that others can contribute

  # Acceptance Criteria:
  # [ ] - I must be signed in
  # [ ] - A project title and description is required
  # [ ] - I am shown errors and the project is not created if validation fails
  # [ ] - After creating I am directed to the project’s details page
  # [ ] - If an project with that name is already in the database, I receive an error

  context "member is authenticated:" do
    before(:each) do
      sign_in(member)
      visit root_path
      click_link('Add Project')
    end

    scenario "member properly fills out the form and submits a project" do
      fill_in 'Name', with: 'build website'
      fill_in 'Description', with: 'it needs to get done!'
      click_button 'Submit'
      expect(page).to have_content('Your project has been successfully created!')
      expect(page).to have_content('it needs to get done!')
    end

    scenario "member does not provide project name and description" do
      click_button 'Submit'
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
    end

    scenario "if a project with that name already exists, member receives an error" do
      fill_in 'Name', with: 'build website'
      fill_in 'Description', with: 'it needs to get done!'
      click_button 'Submit'
      expect(page).to have_content('Your project has been successfully created!')
      expect(page).to have_content('it needs to get done!')

      click_link 'All Projects'
      click_link 'Add New Project'
      fill_in 'Name', with: 'build website'
      fill_in 'Description', with: 'it needs to get done!'
      click_button 'Submit'
      expect(page).to have_content('Name has already been taken')
    end
  end

  context "member is not authenticated" do
    scenario "member cannot add an project" do
      visit root_path
      expect(page).to_not have_content('Add Project')
    end

    scenario "member cannot access new project url" do
      visit new_project_path
      expect(page).to_not have_content('Add Project')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
