require 'test_helper'
include UserHelpers
include ProjectHelpers
include StatusesHelper

class Statuses < Capybara::Rails::TestCase
  before do
    register_with('Carlos', 'proj@email.com', '123456')
    login_with('proj@email.com', '123456')
    create_project('My new project')
  end

  scenario "create new status", js: true do
    create_status('There is a test status')

    assert find('#statuses-list').has_text?('There is a test status')
  end

  scenario "fails to create status wthout text", js: true do
    create_status('')

    assert page.has_text?('Project status message can not be added.')
  end

  scenario "deletes status", js: true do
    create_status('Chuck Norris is our everything')

    page.accept_confirm do
      within '#statuses-list' do
        first(:link, 'Delete').click
      end
    end

    assert page.has_text?('You just deleted a status.')
  end

  scenario "edit status", js: true do
    create_status('Bad day')

    within "#statuses-list" do
      within first(".status") do
        click_link "Edit"
      end
    end
    fill_in "status[text]", with: "Good day"
    click_button "Update"

    assert page.has_text?('Status message has been successfully updated.')
  end

  scenario "fails to edit status without text", js: true do
    create_status('Great day')

    within "#statuses-list" do
      within first(".status") do
        click_link "Edit"
      end
    end
    fill_in "status[text]", with: ""
    click_button "Update"

    assert page.has_text?('Status message has not been updated.')
  end

  scenario "can edit status color", js: true do
    create_status('Project is good', 'red')

    within "#statuses-list" do
      within first(".status") do
        click_link "Edit"
      end
    end
    within "#statuses-list .edit_status" do
      select "green", :from => "status[color]"
    end
    click_button "Update"
    # we suppose that there is only one panel-success on the page (only one status)
    assert page.must_have_selector('.panel.panel-success')
  end

  # it "can cancel editing status"

  # it "fails to add status in archived project"
  # it "fails to edit status in archived project"
  # it "fails to delete status in archived project"
end
