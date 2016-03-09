class AppController < ApplicationController
  # We use this controller to defend all the
  # business logic from not authenticated users
  before_filter :require_login

  before_action :get_workspaces

  private

  def get_workspaces
    @workspaces = current_user.workspaces
  end
end
