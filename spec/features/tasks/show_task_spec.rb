
feature "member views all tasks:" do
  let(:member) { FactoryBot.create(:member) }
  let!(:project) { FactoryBot.create(:project_with_tasks) }
  let(:task) { project.tasks.first }

  # As an authenticated member
  # I want to view the details about a task
  # So that I can get more information about it
  #
  # Acceptance Criteria:
  #  [X] - I must be signed in
  #  [X] - I am able to reach the task show page from the project detail page
  #  [X] - I am able to view the task's title and description
  #  [ ] - I am able to view the members currently working on the task
  #  [ ] - I am able to view task keywords, needs, and proposed deadline
  #  [ ] - I am able to view task issues

  context "member is authenticated:" do
    before(:each) do
      sign_in(member)
      visit projects_path
      click_link "#{project.name}"
      click_link "#{task.name}"
    end

    scenario "member visits task show page and views task information" do
      expect(page).to have_current_path(project_task_path(project, task))
      expect(page).to have_content("#{task.name}")
      expect(page).to have_content("#{task.description}")
      expect(page).to have_content("#{task.keywords}")
      expect(page).to have_content("#{task.needs}")
      expect(page).to have_content("#{task.updated_at.to_formatted_s(:long)}")
    end

    scenario "member views members currently working on the task"

    scenario "member views task deadline and open issues"
  end

  context "member is not authenticated:" do
    scenario "member cannot view tasks" do
      sign_out(member)
      visit project_task_path(project, task)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
