class LandingController < ApplicationController
  layout 'landing'

  def index
    @user = User.new
  end

end
