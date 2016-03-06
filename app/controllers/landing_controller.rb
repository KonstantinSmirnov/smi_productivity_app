class LandingController < ApplicationController
  layout 'landing'
  def index
    @user = User.new
  end

  def sign_up
    respond_to do |format|
      @user = User.new(user_params)
      if @user.save
        flash.now[:success] = 'Welcome! Please check activation letter in your email box.'
        #redirect_to root_path
        format.js { render 'signup_message' }
      else
        #render 'new'
        format.js { render 'render_signup_errors' }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
