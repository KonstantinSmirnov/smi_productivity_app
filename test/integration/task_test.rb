require 'test_helper'
include UserHelpers
include ProjectHelpers

class Tasks < Capybara::Rails::TestCase
  before do
    register_with('Alexey', 'alex@mail.com', '123456')
    login_with('alex@mail.com', '123456')
    create_project('This is a project')
  end

  # it "can create a new task"
  # it "fails to create a new task with empty name"
  # it "can update a task"
  # it "can update a task with empty name"
  # it "can remove a task"
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
