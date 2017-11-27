
feature "member views all tasks" do
  let(:member) { FactoryBot.create(:member) }
  let!(:project) { FactoryBot.create(:project_with_tasks) }
  let(:first_task) { project.tasks.first }
  let(:last_task) { project.tasks.last }

  # As an authenticated member
  # I want to view a list of tasks
  # So that I know what is being done on a project
  #
  # Acceptance Criteria:
  #  [ ] - I must be signed in
  #  [ ] - I must be on the project detail page and see only the tasks for that project
  #  [ ] - I am able to view a listing of all open tasks by title and description
  #  [ ] - Tasks are listed in order, most recent first
  #  [ ] - I am able to view task keywords, needs, and member assignments

  context "member is authenticated" do
    before(:each) do
      sign_in(member)
      visit projects_path
      click_link "#{project.name}"
    end

    scenario "member visits project page and views all tasks" do
      expect(page).to have_current_path(project_path(project))
      expect(page).to have_content("#{first_task.name}")
      expect(page).to have_content("#{first_task.description}")
      expect(page).to have_content("#{first_task.keywords}")
      expect(page).to have_content("#{first_task.needs}")
      expect(page).to have_content("#{last_task.name}")
      expect(page).to have_content("#{last_task.description}")
      expect(page).to have_content("#{last_task.keywords}")
      expect(page).to have_content("#{last_task.needs}")
    end

    scenario "tasks are listed in correct order" do
      content = first('section.task header p span.upd_at').text
      expect(content).to eq("Last Updated: #{last_task.updated_at.to_formatted_s(:long)}")
    end
  end

  context "member is not authenticated" do
    scenario "member cannot view tasks" do
      sign_out(member)
      visit project_path(project)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
