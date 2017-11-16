
feature "member signs out:" do
  let(:member) { FactoryBot.create(:member) }

  before :each do
    visit root_path
    fill_in 'Email', with: member.email
    fill_in 'Password', with: member.password
    click_button 'Sign In'
  end

  # As an authenticated member
  # I want to sign out
  # So that no one else can use my account on my behalf

  # Acceptance Criteria:
  # [X] - I must be signed in
  # [ ] - I must be able to sign out from any page
  # [X] - I am notified of successful sign-out and redirected to the home page
  # [ ] - I am unable to access other pages or view account details after signing out
  # [ ] - When I click the sign-out link I am signed out and my session is cleared

  scenario "member clicks sign-out link and session is cleared" do
    click_link 'Sign Out'
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Sign In')
    expect(page).to have_current_path(root_path)
  end
end
