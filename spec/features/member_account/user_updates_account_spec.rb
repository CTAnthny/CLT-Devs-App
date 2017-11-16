
feature "member updates account:" do
  let(:member) { FactoryBot.create(:member) }

  before :each do
    visit root_path
    fill_in 'Email', with: member.email
    fill_in 'Password', with: member.password
    click_button 'Sign In'
  end

  # As an authenticated member
  # I want to update my information
  # So that I can keep my profile up to date

  # Acceptance Criteria:
  # [X] - I must be signed in and authenticated
  # [X] - I am able to reach the edit page from the nav bar
  # [X] - I am able to update profile details
  # [X] - Invalid field inputs provide error notifications and prevent an update
  # [X] - After successful update I am notified and redirected to the account show page
  # [X] - An unauthenticated member is redirected when visiting the update url

  scenario "changes account information" do
    click_link 'Edit Account'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'nobody2@example.com'
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password Confirmation', with: 'newpassword'
    fill_in 'Current Password', with: 'password'
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
    expect(page).to have_content('Sign Out')
    expect(page).to have_current_path(root_path)
  end

  scenario "member's current password must be provided to authenticate changes" do
    click_link 'Edit Account'
    click_button 'Update'
    expect(page).to have_content("can't be blank")
  end

  scenario "an unauthenticated member cannot edit information" do
    click_link 'Sign Out'
    expect(page).to_not have_content('Edit Account')
  end

  scenario "an unauthenticated member is redirected when visiting the edit url" do
    click_link 'Sign Out'
    visit edit_member_registration_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
