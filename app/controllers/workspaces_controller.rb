class WorkspacesController < AppController

  def create
    @workspace = current_user.workspaces.build(title: params[:title])
    if @workspace.save
      @user = User.find(current_user.id)
      @user.skip_password = true
      @user.workspace = @workspace
      @user.workspaces << @workspace
      if @user.save
        flash[:success] = "New workspace has been created"
        redirect_to workspace_dashboard_path(@user.workspace)
      else
        flash.now[:danger] = "Workspace can not be created"
        render 'edit'
      end
    end
  end

  def show
    @workspace = Workspace.find(params[:id])
    @user = User.find(current_user.id)
    @user.skip_password = true
    @user.workspace = @workspace
    if @user.save
      flash[:success] = "New workspace has been selected"
    else
      flash[:danger] = "New workspace has not been selected"
    end
    redirect_to workspace_dashboard_path(current_user.workspace)
  end

  def edit
    @workspace = Workspace.find(params[:id])

  end

  def update
    @workspace = Workspace.find(params[:id])

    if @workspace.update_attributes(workspace_params)
      flash[:success] = "Workspace parameters have been successfully updated"
      redirect_to edit_workspace_path(@workspace)
    else
      flash.now[:danger] = "Workspace parameters can not be updated"
      render 'edit'
    end

  end

  def destroy
    @workspace = Workspace.find(params[:id])
    if @workspace.destroy
      flash[:success] = "Workspace has been deleted"
      redirect_to workspace_dashboard_path(current_user.workspace)
    else
      flash.now[:danger] = "Workspace has not been deleted"
      render 'edit'
    end
  end

  def workspace_params
    params.require(:workspace).permit(:title)
  end

end
