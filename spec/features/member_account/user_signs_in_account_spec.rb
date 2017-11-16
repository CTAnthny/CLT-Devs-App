
feature "member signs in:" do
  let(:member) { FactoryBot.create(:member) }

  before :each do
    visit root_path
  end

  # As an unauthenticated member
  # I want to sign in
  # So that the application can identify me

  # Acceptance Criteria:
  # [X] - I must be able to sign in from the home page
  # [ ] - If I am not signed in and try to access other pages I am redirected to login
  # [X] - If I specify a valid, previously registered email and password,
  #    I am authenticated, gain access to the system, and I am notified of success
  # [X] - If I specify an invalid email and password, I remain unauthenticated, and
  #    I am presented with the error(s)
  # [X] - If I am already signed in, I can't sign in again

  scenario "an existing member specifies a valid email and password" do
    fill_in 'Email', with: member.email
    fill_in 'Password', with: member.password
    click_button 'Sign In'
    expect(page).to have_content('Welcome Back!')
    expect(page).to have_content('Sign Out')
  end

  scenario "a non-existent email and password is supplied" do
    fill_in 'Email', with: 'nobody@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'
    expect(page).to have_content('Invalid Email or Password')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario "an existing email with the wrong password is denied access" do
    fill_in 'Email', with: member.email
    fill_in 'Password', with: 'incorrectPassword'
    click_button 'Sign In'
    expect(page).to have_content('Invalid Email or Password')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario "an already authenticated member cannot re-sign in" do
    fill_in 'Email', with: member.email
    fill_in 'Password', with: member.password
    click_button 'Sign In'
    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit new_member_session_path
    expect(page).to have_content('You are already signed in.')
  end

  scenario "an unauthenticated member cannot access other pages"
end
