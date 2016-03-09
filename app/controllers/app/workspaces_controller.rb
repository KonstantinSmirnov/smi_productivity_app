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

  def update
    @current_workspace = Workspace.find(params[:id])

    respond_to do |format|
      if @current_workspace.update_attributes(workspace_params)
        flash[:success] = "Workspace info has been successfully updated."
        format.html { render 'show' }
      else
        flash[:warning] = "Workspace info could not be updated due to a problem."
        format.html { render 'show' }
      end
    end
  end

  def destroy
    respond_to do |format|
      @current_workspace = Workspace.find(params[:id])
      if current_user.id == @current_workspace.user_id
        @current_workspace.destroy
        flash[:success] = "Workspace has been successfully destroyed"
        format.html { redirect_to app_dashboard_path }
      else
        flash[:danger] = "An error occured during workspace deleting."
        format.html { render 'show' }
      end
    end
  end


  private

  def workspace_params
    params.require(:workspace).permit(:title)
  end

  def has_access?
    @current_workspace = Workspace.find(params[:id])
    redirect_to(app_dashboard_path) unless current_user.id == @current_workspace.user_id
  end
end
