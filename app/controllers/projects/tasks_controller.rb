class Projects::TasksController < AppController

  def index
    @current_project = Project.find(params[:project_id])
    @tasks = @current_project.tasks.reverse
  end

  def create
    @current_project = Project.find(params[:project_id])
    @task = @current_project.tasks.build(title: params[:title])

    respond_to do |format|
      if @task.save
        format.js { render 'add_task', :object => @task }
      else
        @alert = {:type => 'danger', :message => 'Task has not been created.'}
        format.js { render 'shared/render_alert' }
      end
    end
  end

  def update
    @current_project = Project.find(params[:project_id])
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(task_params)
        @alert = {:type => 'success', :message => 'Task has been updated.'}
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

  def update_description
    @current_project = Project.find(params[:project_id])
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(task_params)
        @alert = {:type => 'success', :message => 'Task description has been updated.'}
        format.js { render 'render_description' }
      else
        @alert = {:type => 'danger', :message => 'Task description was not updated.'}
        format.js { render 'shared/render_alert' }
      end
    end
  end

  def get_task_details
    @task = Task.find(params[:id])
    @current_project = Project.find(params[:project_id])
    @new_comment = Comment.new

    respond_to do |format|
      if @task
        format.js { render 'show_task_details', :object => @task }
      else
        @alert = {:type => 'danger', :message => 'Task was not found'}
        format.js { render 'shared/render_alert' }
      end

    end
  end

  def edit_due_date
    @task = Task.find(params[:id])
    @current_project = Project.find(params[:project_id])

    respond_to do |format|
      format.js { render 'show_due_date_calendar', :object => @task }
    end
  end

  def update_due_date
    @current_project = Project.find(params[:project_id])
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(task_params)
        @alert = {:type => 'success', :message => 'Task due date has been updated.'}
        format.js { render 'update_task' }
      else
        @alert = {:type => 'danger', :message => 'Task due_date was not updated.'}
        format.js { render 'shared/render_alert' }
      end
    end
  end

  def destroy
    @current_project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    @task_id = @task.id

    respond_to do |format|
      if @task.delete
        @alert = {:type => 'warning', :message => 'You just deleted a task.'}
        format.js { render 'hide_task' }
      else
        format.js { render 'delete_task_message' }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date)
  end

end

