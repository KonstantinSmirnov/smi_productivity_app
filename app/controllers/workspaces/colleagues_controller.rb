class Workspaces::ColleaguesController < AppController

  def index
    @workspace = Workspace.find(params[:workspace_id])
  end
end
