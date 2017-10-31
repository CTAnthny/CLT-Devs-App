
feature "user creates account" do
  # As a prospective user
  # I want to create an account
  # So that I can sign up for tasks / projects and view them

  # Acceptance Criteria:
  # [] - From the home page I can click a link to create an account
  # [] - I am prompted for a valid username, email, password, and pw confirmation
  # [] - Invalid inputs fail validation, prevent account creation, and present an error message
  # [] - If I specify valid information, I register my account and am authenticated
  # [] - On successful account creation I am notified and redirected to the account show page
  # [] - On successful account creation I am prompted to update profile fields

  scenario "specifying valid and required information" do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Sign Out")
  end

  scenario "required information is not supplied" do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "password confirmation does not match" do
    visit root_path
    click_link 'Sign Up'

    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'somethingdifferent'
    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
