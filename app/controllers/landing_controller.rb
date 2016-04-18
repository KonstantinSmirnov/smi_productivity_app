class LandingController < ApplicationController
  layout 'landing'

  def index
    @user = User.new
    if current_user
      @current_workspace = current_user.workspace
    end
  end

end
