require 'rails_helper'

feature 'Visitor signs up' do
  scenario 'responds to root_path' do
    visit root_path

    expect(page).to have_css('h2', text: 'Awesome landing page')
  end

  scenario 'pass with valid name, email and password', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    expect(page).to have_content('Welcome! Please check activation letter in your email box')
  end

  scenario 'fails if email was already used for registration', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: "a@b.com"
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    fill_in 'signup-name', with: 'Username2'
    fill_in 'signup-email', with: "a@b.com"
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    expect(page).to have_content('Email has already been taken')
  end

  scenario 'fails with invalid email', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: 'a@a'
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    expect(page).to have_content('Email is invalid')
  end

  scenario 'fails without email', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: ''
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    expect(page).to have_content('Email is invalid')
  end

  scenario 'fails without name', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: ''
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    expect(page).to have_content('Name is too short (minimum is 3 characters)')
  end

  scenario 'fails with name less than 3 symbols', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'ab'
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '123456'
    click_button 'Register'

    expect(page).to have_content('Name is too short (minimum is 3 characters)')
  end

  scenario 'fails without password', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: ''
    fill_in 'signup-passconf', with: ''
    click_button 'Register'

    expect(page).to have_content('Password is too short (minimum is 6 characters)')
  end

  scenario 'fails if pass does not match passconf', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: '123456'
    fill_in 'signup-passconf', with: '789123'
    click_button 'Register'

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'fails if password is less than 6 symbols', js: true do
    visit root_path

    click_button 'SIGN UP'
    fill_in 'signup-name', with: 'Username'
    fill_in 'signup-email', with: 'a@a.com'
    fill_in 'signup-pass', with: '123'
    fill_in 'signup-passconf', with: '123'
    click_button 'Register'

    expect(page).to have_content("Password is too short (minimum is 6 characters)")
  end

  it 'fails if user did not activate its account'

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

    expect(page).to have_content("Welcome back!")
  end


end
