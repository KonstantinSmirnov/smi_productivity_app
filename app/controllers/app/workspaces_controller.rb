class App::WorkspacesController < AppController
  before_action :has_access?, except: [:create]

  def show
    @current_workspace = Workspace.find(params[:id])
  end

  def create
    @user = User.find(current_user)
    @workspace = @user.workspaces.build(title: params[:title])

    respond_to do |format|
      if @workspace.save
        flash[:success] = 'Congratulations! New workspace has been created!'
        format.html { redirect_to app_workspace_path(@workspace) }
      else
        flash[:danger] = 'New workspace can not be created.'
        format.html { redirect_to app_dashboard_path}
      end
    end
  end
  
  def edit
    @current_workspace = Workspace.find(params[:id])
  end

  def update
    @current_workspace = Workspace.find(params[:id])

    respond_to do |format|
      if @current_workspace.update_attributes(workspace_params)
        flash.now[:success] = "Workspace info has been successfully updated."
        format.html { render 'edit' }
      else
        flash.now[:warning] = "Workspace info could not be updated due to a problem."
        format.html { render 'edit' }
      end
    end
  end

  def destroy
      if User.authenticate(current_user.email, params[:workspace][:password])
        @current_workspace = Workspace.find(params[:id])
        if current_user.id == @current_workspace.user_id
          @current_workspace.destroy
          flash[:success] = "Workspace has been successfully destroyed"
          render js: "window.location='#{app_dashboard_path}'"
        else
          flash.now[:danger] = "This is no your workspace, it can not be deleted."
          format.html { render 'edit' }
        end
      else
        respond_to do |format|
          flash.now[:danger] = "You entered an incorrect password"
          format.js { render 'delete_error_message' }
        end
      end
  end

  private

  def workspace_params
    params.require(:workspace).permit(:title)
  end

  def has_access?
    if Workspace.exists?(params[:id])
      @current_workspace = Workspace.find(params[:id])
      if current_user.id != @current_workspace.user_id
        flash[:danger] = "You have no access to this workspace"
        redirect_to app_dashboard_path
      end
    else
      flash[:danger] = "Workspace does not exist."
      redirect_to app_dashboard_url
    end
  end
  
end
