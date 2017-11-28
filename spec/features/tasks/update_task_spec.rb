
feature "member updates task" do
  let(:member) { FactoryBot.create(:member) }
  let!(:project) { FactoryBot.create(:project_with_tasks, tasks_count: 1) }
  let!(:task) { project.tasks.first }
  # The :project_with_tasks factory instantiates it's own Member for an associated task that must be referenced
  # let!(:member) { Member.find(task.member_id) }

  # As an authenticated member
  # I want to update a task's details
  # So that I can correct errors or provide new information
  #
  # Acceptance Criteria:
  #  [ ] - I must be signed in
  #  [ ] - I can reach the task's edit page from the project details page
  #  [ ] - I must be able to edit task details
  #  [ ] - I must be presented with errors if I fill out the form incorrectly
  #  [ ] - Upon successful update I am returned to the task show page

  context "member is authenticated" do
    before(:each) do
      sign_in(member)
      visit projects_path
      click_link "#{project.name}"
      click_link "#{task.name}"
      click_link "Edit Task"
    end

    scenario "member can reach the edit page from details page" do
      expect(page).to have_current_path(edit_project_task_path(project, task))
    end

    scenario "member correctly edits task" do
      fill_in 'Description', with: "super awesome project task!!"
      click_button 'Submit'
      expect(page).to have_current_path(project_task_path(project, task))
      expect(page).to have_content("Your task has been successfully updated!")
      expect(page).to have_content("super awesome project task!!")
    end

    scenario "member incorrectly fills out edit form" do
      fill_in 'Description', with: ""
      click_button 'Submit'
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "member is not authenticated" do
    scenario "member cannot view tasks" do
      sign_out(member)
      visit edit_project_task_path(project, task)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
