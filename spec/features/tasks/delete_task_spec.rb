
feature "member deletes task:" do
  let(:member) { FactoryBot.create(:member) }
  let!(:project) { FactoryBot.create(:project_with_tasks, tasks_count: 1) }
  let!(:task) { project.tasks.first }

  # As an authenticated and authorized member
  # I want to delete a task
  # So that no one can view it
  #
  # Acceptance Criteria:
  #  [ ] - I must be signed in
  #  [ ] - I must be authorized
  #  [ ] - I must be able delete a task from the task edit page
  #  [ ] - I must be able delete a task from the task show page
  #  [ ] - After deleting I am returned to the project show page

  context "member is authenticated:" do
    before(:each) do
      sign_in(member)
      visit projects_path
      click_link "#{project.name}"
    end

    scenario "member is authorized to delete tasks"

    scenario "member deletes task from the task edit page" do
      click_link "#{task.name}"
      click_link "Edit Task"
      click_link "Delete Task"
      expect(page).to have_current_path(project_path(project))
      expect(page).to have_content("Your task has been successfully deleted!")
      expect(page).to_not have_content("#{task.name}")
      expect(page).to_not have_content("#{task.description}")
    end

    scenario "member deletes task from the task show page" do
      click_link "#{task.name}"
      click_link "Delete Task"
      expect(page).to have_current_path(project_path(project))
      expect(page).to have_content("Your task has been successfully deleted!")
      expect(page).to_not have_content("#{task.name}")
      expect(page).to_not have_content("#{task.description}")
    end
  end

  context "member is not authenticated:" do
    scenario "member cannot delete tasks" do
      sign_out(member)
      visit project_task_path(project, task)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
