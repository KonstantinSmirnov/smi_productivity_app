require 'test_helper'
include UserHelpers
include ProjectHelpers

class Projects < Capybara::Rails::TestCase

  before do
    register_with('Projects', 'projects@email.com', '123456')
    login_with('projects@email.com', '123456')
  end

  scenario "created with correct title", js: true do
    create_project('Test project')
    assert page.has_text?('Congratulations! New project has been created!')
  end

  scenario "fails without title", js: true do
    create_project('')
    assert page.has_text?('New project can not be created.')
  end

  scenario "updates with correct title", js: true do
    create_project('Arnold')

    find(".project-settings").find(".fa-cog").click
    fill_in 'project_title', with: 'Terminator'
    click_button 'Update'

    assert page.has_text?('Project info has been successfully updated.')
  end

  scenario "fails to update with no title", js: true do
    create_project('Rockie')

    find(".project-settings").find(".fa-cog").click
    fill_in 'project_title', with: ""
    click_button 'Update'

    assert page.has_text?('Project info could not be updated due to a problem.')
  end

  scenario "archives with corerct password", js: true do
    create_project('How are you today?')

    find(".project-settings").find(".fa-cog").click
    click_link 'Archive project'
    fill_in 'project_password', with: '123456'
    click_button "Yes, I confirm this action."

    assert page.has_text?('Project has been successfully archived/unarchived')
  end

  scenario "fails to archive with incorrect password", js: true do
    create_project('Dragons and cookies')

    find(".project-settings").find(".fa-cog").click
    click_link 'Archive project'
    fill_in 'project_password', with: ''
    click_button 'Yes, I confirm this action.'

    assert page.has_text?('Your password is wrong. Please use correct password.')
  end

  scenario "unarchived with correct password", js: true do
    create_project("Santa Barbara")
    archive_current_project

    find(".project-settings").find(".fa-cog").click
    click_link 'Unarchive project'
    fill_in 'project_password', with: '123456'
    click_button "Yes, I confirm this action."

    assert page.has_text?('Project has been successfully archived/unarchived')
  end

  scenario "fails to unarchive with incorrect password", js: true do
    create_project("Titanic")
    archive_current_project

    find(".project-settings").find(".fa-cog").click
    click_link 'Unarchive project'
    fill_in 'project_password', with: ''
    click_button "Yes, I confirm this action."

    assert page.has_text?('Your password is wrong. Please use correct password.')

  end

  scenario "removes with a correct password", js: true do
    create_project('A big travel')

    find(".project-settings").find(".fa-cog").click
    click_link "Delete project"
    fill_in 'project_password', with: '123456'
    click_button "I want to delete this project permanently"

    assert page.has_text?('Project has been successfully destroyed')
  end

  scenario "fails to remove with incorrect password", js: true do
    create_project('Another travel')

    find(".project-settings").find(".fa-cog").click
    click_link "Delete project"
    fill_in 'project_password', with: ''
    click_button "I want to delete this project permanently"

    assert page.has_text?('Your password is wrong. Please use correct password.')
  end

end
