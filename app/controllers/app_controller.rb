class AppController < ApplicationController
  # We use this controller to defend all the
  # business logic from not authenticated users
  before_filter :require_login

  before_action :get_projects

  private

  def get_projects
    @current_workspace = current_user.workspace
    @workspaces_list = current_user.workspaces - [@current_workspace]
    @projects = current_user.projects
  end
end
