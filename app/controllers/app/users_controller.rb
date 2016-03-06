class App::UsersController < AppController
  before_action :edit_rights?

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User details were successfully updated"
      render 'edit'
    else
      flash[:warning] = "You have provided incorrect data"
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def edit_rights?
    @user = User.find(params[:id])
    redirect_to(app_dashboard_path) unless current_user == @user
end
end
