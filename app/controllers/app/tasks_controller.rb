class App::TasksController < AppController
  before_action :has_access?

  def index
    @current_project = Project.find(params[:project_id])
    @tasks = @current_project.tasks
  end

  def create
    @current_project = Project.find(params[:project_id])
    @task = @current_project.tasks.build(title: params[:title])

    respond_to do |format|
      if @task.save
        format.js { render 'add_task', :object => @task }
      else
        @alert = {:type => 'danger', :message => 'Task can not be created.'}
        format.js { render 'render_message' }
      end
    end
  end

  def update
    @current_project = Project.find(params[:project_id])
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(task_params)
        flash.now[:success] = 'Task has been updated'
        format.js { render 'update_task', :object => @task }
      else
        format.js { render 'update_task_message' }
      end
    end
  end

  def update_task_status
    @current_project = Project.find(params[:project_id])
    @tasks = @current_project.tasks
    @task = Task.find(params[:id])
    @task.toggle(:done?)

    respond_to do |format|
      if @task.save
        if @task.done? == true
          @alert = {:type => 'success', :message => 'The task is done. Congratulations!'}
        else
          @alert = {:type => 'warning', :message => 'You undone the task.'}
        end
        format.js { render 'update_task', :object => @task }
      else
        flash.now[:danger] = "Task status has not been updated"
        format.html { render 'index' }
      end
    end
  end

  def destroy
    @current_project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    @task_id = @task.id

    respond_to do |format|
      if @task.delete
        format.js { render 'hide_task', :object => @task_id }
      else
        format.js { render 'delete_task_message' }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end

  def has_access?
    if Project.exists?(params[:project_id])
      @current_project = Project.find(params[:project_id])
      if current_user.id != @current_project.user_id
        flash[:danger] = "You have no access to this project"
        redirect_to app_dashboard_path
      end
    else
      flash[:danger] = "Project does not exist."
      redirect_to app_dashboard_url
    end
  end
end

