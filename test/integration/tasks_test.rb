require 'test_helper'
include UserHelpers
include ProjectHelpers
include TaskHelpers

class Tasks < Capybara::Rails::TestCase
  before do
    register_with('Alexey', 'alex@mail.com', '123456')
    login_with('alex@mail.com', '123456')
    create_project('This is a project')
  end

  scenario "create with correct title", js: true do
    fill_in "new-task-field", with: 'Eat an apple'
    click_button "Add"

    within ".tasks-list" do
      assert find('.task').has_text?('Eat an apple')
    end
  end

  scenario "fails to create without title", js: true do
    create_task('')

    assert page.has_text?('Task has not been created.')
  end

  scenario "update task", js: true do
    create_task('take a fishing rod')

    find(".tasks-list .task .task-options .edit .fa-pencil", visible: false).trigger(:click)
    fill_in "task_title", with: 'Buy a cup'
    click_button "Update"

    assert page.has_text?('Task has been updated.')

  end

  scenario "fails update with empty name", js: true do
    create_task('I like apples')

    find(".tasks-list .task .task-options .edit .fa-pencil", visible: false).trigger(:click)
    fill_in "task_title", with: ''
    click_button "Update"

    assert page.has_text?('This action failed. May be you tried to use wrong data.')
  end

  scenario "remove task", js: true do
    create_task('Welcome to Alabama')

    find(".tasks-list .task .task-options .edit .fa-pencil", visible: false).trigger(:click)
    click_link "Delete"

    assert page.has_text?('You just deleted a task')
  end


  # it "can check task details"
  # it "can add task description"
  # it "can 'done' task"
  # it "can 'undone' task"
  # it "can select due date"
  # it "due to date is blue if future"
  # it "due to date is yellow if today"
  # it "due to date is red if past"

  # it "fails 'done' task in archived project"
  # it "fails 'undone' task in archived project"
  # it "fails select due date in archived task"
end
