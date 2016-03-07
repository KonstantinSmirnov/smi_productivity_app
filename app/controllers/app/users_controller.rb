class App::UsersController < AppController
  before_action :edit_rights?

  def edit
    @user = User.find(params[:id])
  end

  def update_user
    @user = User.find(params[:id])
    @user.skip_password = true

    respond_to do |format|
      if @user.update_attributes(user_params)
        flash[:success] = "your details were successfully updated"
        format.html { redirect_to app_edit_user_path(current_user) }
      else
        flash[:warning] = "You have provided incorrect data"
        format.html { render 'edit' }
      end
    end
  end

  def update_password
    @user = User.find(params[:id])

    respond_to do |format|
      if params[:user][:password].blank? == true
        flash[:warning] = "You have not provided any new password."
        format.html { render 'edit' }
      else
        if @user.update_attributes(user_params)
          flash[:success] = "Your password was successfully updated"
          format.html { redirect_to app_edit_user_path(current_user) }
        else
          flash[:warning] = "Password and password confirmation are not same"
          format.html { render 'edit' }
        end
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if User.authenticate(@user.email, params[:user][:password])
      flash[:success] = "Your account has been permanently deleted!"
      @user.destroy
      render js: "window.location='#{root_path}'"
    else
      respond_to do |format|
        format.js { render 'delete_error_message' }
      end
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def edit_rights?
    @user = User.find(params[:id])
    redirect_to(app_dashboard_path) unless current_user == @user
  end

end
