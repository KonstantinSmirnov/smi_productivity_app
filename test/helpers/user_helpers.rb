module UserHelpers
  def register_with(name, email, password)
    visit root_path
    click_button 'SIGN UP'
    fill_in 'signup-name', with: name
    fill_in 'signup-email', with: email
    fill_in 'signup-pass', with: password
    fill_in 'signup-passconf', with: password
    click_button 'Register'
  end

  def login_with(email, password)
    # need to be sure that signed out
    visit root_path
    click_link 'Sign in'
    fill_in 'signin-email', with: email
    fill_in 'signin-pass', with: password
    click_button 'Sign in'
  end
end
