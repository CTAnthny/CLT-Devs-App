
feature "member views all projects:" do
  let(:member) { FactoryBot.create(:member) }
  before(:all) { 25.times { FactoryBot.create(:project) } }
  after(:all) { Project.delete_all }

  # As an authenticated member
  # I want to view a list of projects
  # So that I can pick projects to join
  #
  # Acceptance Criteria:
  # [X] - I must be logged in to view projects
  # [X] - I must be able to see the project name, description, and creator
  # [X] - I must see projects listed in order, most recently updated first
  # [X] - I must be able to page view projects

  context "member is authenticated:" do
    before(:each) do
      sign_in(member)
      visit projects_path
    end

    scenario "member views projects with details" do
      expect(page).to have_content("#{Project.last.name}")
      expect(page).to have_content("#{Project.last.description}")
      expect(page).to have_content("#{Project.last.updated_at.to_formatted_s(:long)}")
      expect(page).to have_content('John Smith')
    end

    scenario "member views project in correct order" do
      content = first('section.project header p span.upd_at').text
      last_upd_project = Project.last
      expect(content).to eq("Last Updated: #{last_upd_project.updated_at.to_formatted_s(:long)}")
    end

    scenario "member is able to paginate projects" do
      expect(page).to have_selector('nav.pagination')

      Project.page(2).each do |project|
        expect(page).to have_selector('h2.project-title a', text: project.name)
      end
    end
  end

  context "member is not authenticated:" do
    scenario "member cannot view projects" do
      sign_out(member)
      visit projects_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).to_not have_content('MyString 1')
      expect(page).to_not have_content('John Smith')
    end
  end
end
