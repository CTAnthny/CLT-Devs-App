
feature "member deletes account:" do

  # As an authenticated member
  # I want to delete my account
  # So that my information is no longer retained by the app

  # Acceptance Criteria:
  # [X] - I must be signed in and authenticated
  # [X] - I am able to click a delete account link from the account show page
  # [X] - I am provided with a confirmation notice
  # [X] - After successful deletion I am notified and redirected to the home page
  # [X] - I am unable to delete other users’ accounts
  # [X] - After deleting an account the member cannot re-sign in

  scenario "member must be authenticated to delete account" do
    visit root_path
    expect(page).to_not have_content('Cancel my account')
  end

  scenario "an unauthenticated member is redirected from the delete url" do
    visit cancel_member_registration_path
    expect(page).to have_content('Sign Up')
    expect(page).to_not have_content('Cancel my account')
  end

  scenario "member deletes account and cannot re-sign in" do
    member = FactoryBot.create(:member)
    visit root_path
    fill_in 'Email', with: member.email
    fill_in 'Password', with: member.password
    click_button 'Sign In'
    click_link('Edit Account')
    click_link('Cancel My Account')

    expect(page).to have_content('Your account has been successfully cancelled. We hope to see you again soon.')
    expect(page).to_not have_content('Sign Out')

    fill_in 'Email', with: member.email
    fill_in 'Password', with: member.password
    click_button 'Sign In'

    expect(page).to have_content('Invalid Email or Password.')
  end
end
