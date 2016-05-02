class Workspaces::ColleaguesController < AppController

  def index
    @workspace = Workspace.find(params[:workspace_id])
  end

  def add_user
    @workspace = Workspace.find(params[:workspace_id])
    respond_to do |format|
      if @user = User.find_by_email(params[:email])
        if @workspace.users.include? @user
          @alert = { :type => 'danger', :message => 'This user already exists in thei workspace.' }
          format.js { render 'shared/render_alert' }
        else
          @workspace.users << @user
          @user.connections.find_by_workspace_id(@workspace.id).pending!
          flash[:success] = "User has been added"
          format.js { render :js => "window.location.href='"+workspace_colleagues_path(@workspace)+"'" }
        end
      else
        @alert = { :type => 'success', :message => 'Invitation has been sent to user'}
        format.js { render 'shared/render_alert' }
      end
    end
  end

  def remove_user
    @workspace = Workspace.find(params[:workspace_id])
    @connection = @workspace.connections.find_by_user_id(params[:id])
    respond_to do |format|
      if @connection.destroy
        flash[:warning] = "User has been deleted"
        format.js { render :js => "window.location.href='"+workspace_colleagues_path(@workspace)+"'" }
      else
        @alert = { :type => 'danger', :message => 'User was not removed from workspace.' }
        format.js { render 'shared/render_alert' }
      end
    end
  end
end
