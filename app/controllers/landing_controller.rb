class LandingController < ApplicationController
  layout 'landing'

  def index
    @user = User.new
    @current_workspace = current_user.workspace
  end

end
