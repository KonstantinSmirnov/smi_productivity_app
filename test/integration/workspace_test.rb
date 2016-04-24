require 'test_helper'
include UserHelpers
include ProjectHelpers

class Workspaces < Capybara::Rails::TestCase
  before do
    register_with('Alexey', 'alex@mail.com', '123456')
    login_with('alex@mail.com', '123456')
  end

  # it "create a default workspace"
  # it "can remove workspace"
  # it "can create a new workspace if all workspaces were removed"
  # it "can rename a workspace"
  # it "fails to rename a workspace with empty title"
  # it "user is an admin in a default workspace"
  # it "workspace admin can change its role"

end
