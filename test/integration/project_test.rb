require 'test_helper'

class Projects < Capybara::Rails::TestCase
  include UserHelpers
  
  it "created with correct title"
  it "fails without title"
  it "updated"
  it "archived with correct password"
  it "fails to be archived with incorrect password"
  it "unarchived with correct password"
  it "fails to be unarchived with incorrect password"
  it "removed with correct password"
  it "fails to be removed with incorrect password"
end