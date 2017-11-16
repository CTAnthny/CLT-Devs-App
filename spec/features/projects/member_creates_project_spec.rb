
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
  # [ ] - If an task with that name is already in the database, I receive an error

  context "member is authenticated:" do
    before(:each) do
      sign_in(member)
      visit root_path
      click_link('Add Task')
    end

    scenario "member properly fills out the form and submits a task" do
      fill_in 'Name', with: 'build website'
      fill_in 'Description', with: 'it needs to get done!'
      click_button 'Submit'
      expect(page).to have_content('Your task has been successfully submitted!')
      expect(page).to have_content('it needs to get done!')
      expect(page).to have_current_path(task_path(task))
    end

    scenario "member does not provide task name and description" do
      click_button 'Submit'
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
    end

    scenario "if a task with that name already exists, member receives an error" do
      fill_in 'Name', with: 'build website'
      fill_in 'Description', with: 'it needs to get done!'
      click_button 'Submit'
      expect(page).to have_content('Your task has been successfully submitted!')
      expect(page).to have_content('it needs to get done!')

      click_link 'Add task'
      fill_in 'Name', with: 'build website'
      fill_in 'Description', with: 'it needs to get done!'
      click_button 'Submit'
      expect(page).to have_content('Name has already been taken')
    end
  end

  context "member is not authenticated" do
    scenario "member cannot add an task" do
      visit root_path
      expect(page).to_not have_content('Add task')
    end

    scenario "member cannot access new task url" do
      visit new_task_path
      expect(page).to_not have_content('Add task')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
