require 'test_helper'

class Users < Capybara::Rails::TestCase

  scenario 'responds to root_path' do
    visit root_path

    assert page.has_css?('h2', 'Awesome landing page')
  end

  scenario 'pass with valid name, email and password', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: 'a@test.com'
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    assert page.has_text?('Welcome! Please check activation letter in your email box')
  end

  scenario 'fails if email was already used for registration', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username2'
    fill_in 'signup-email', with: "a@test2.com"
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username2'
    fill_in 'signup-email', with: "a@test2.com"
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    assert page.has_text?('Email has already been taken')
  end

  scenario 'fails with invalid email', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: 'a@a'
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    assert page.has_text?('Email is invalid')
  end

  scenario 'fails without email', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: ''
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    assert page.has_text?('Email is invalid')
  end

  scenario 'fails without name', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: ''
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    assert page.has_text?('Name is too short (minimum is 3 characters)')
  end

  scenario 'fails with name less than 3 symbols', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'ab'
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    assert page.has_text?('Name is too short (minimum is 3 characters)')
  end

  scenario 'fails without password', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: ''
    fill_in 'signup-passconf', with: ''
    click_button 'Register'

    assert page.has_text?('Password is too short (minimum is 6 characters)')
  end

  scenario 'fails if pass does not match passconf', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '789123'
    click_button 'Register'

    assert page.has_text?("Password confirmation doesn't match Password")

  end

  scenario 'fails if password is less than 6 symbols', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: '123'
    fill_in 'signup-passconf', with: '123'
    click_button 'Register'

    assert page.has_text?('Password is too short (minimum is 6 characters)')
  end

  scenario 'logs in with valid account', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'
    click_link 'Sign In'
    fill_in 'signin-email', with: 'a@a.com'
    fill_in 'signin-pass', with: '123456'
    click_button 'Sign in'

    assert page.has_text?('Welcome back!')
  end

  it "fails to log in if not activated"
  
  it "remove account with correct password"
  it "fails to remove account with incorrect password "
end
