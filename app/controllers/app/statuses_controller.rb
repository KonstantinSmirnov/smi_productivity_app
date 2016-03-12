class App::StatusesController < AppController
  def index
    @current_project = Project.find(params[:project_id])
  end
end
