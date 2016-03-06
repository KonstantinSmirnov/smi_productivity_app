class SessionsController < ApplicationController

  def sign_up
    respond_to do |format|
      @user = User.new(user_params)
      if @user.save
        flash.now[:success] = 'Welcome! Please check activation letter in your email box.'
        format.js { render 'signup_message' }
      else
        format.js { render 'render_signup_errors' }
      end
    end
  end

  def sign_in
      if login(params[:email], params[:password])
        flash.now[:success] = "Welcome back!"
        render js: "window.location='#{dashboard_path}'"
      else
        respond_to do |format|
          flash.now[:warning] = 'Email and/or password is incorrect.'
          format.js { render 'signin_message' }
        end
      end
  end

  def sign_out
    logout
    flash[:success] = "You logged out."
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
