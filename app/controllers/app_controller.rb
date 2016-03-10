class AppController < ApplicationController
  # We use this controller to defend all the
  # business logic from not authenticated users
  before_filter :require_login

  before_action :get_projects

  private

  def get_projects
    @projects = current_user.projects
  end
end
