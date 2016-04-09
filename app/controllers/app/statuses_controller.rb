class App::StatusesController < AppController
  def index
    @current_project = Project.find(params[:project_id])
    @statuses = @current_project.statuses.reverse
    @colors = Status.select(:color).distinct
  end

  def create
    @current_project = Project.find(params[:project_id])
    @status = @current_project.statuses.build(text: params[:text], color: params[:color])
    @status.user = User.find(current_user)

    respond_to do |format|
      if @status.save
        format.js { render 'add_status', :object => @status }
      else
        @alert = { :type => 'danger', :message => 'Project status message can not be added.' }
        format.js { render 'app/shared/render_alert' }
      end
    end
  end

  def edit
    @current_project = Project.find(params[:project_id])
    @status = Status.find(params[:id])
    respond_to do |format|
      format.js { render 'edit_status', :object => @status }
    end
  end

  def cancel_edit
    @current_project = Project.find(params[:project_id])
    @status = Status.find(params[:id])
    respond_to do |format|
      format.js { render 'update_status' }
    end
  end

  def update
    @current_project = Project.find(params[:project_id])
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(status_params)
        @alert = { :type => 'success', :message => 'Status message has been successfully updated.'}
        format.js { render 'update_status' }
      else
        @alert = { :type => 'danger', :message => 'Status message has not been updated.' }
        format.js { render 'app/shared/render_alert' }
      end
    end
  end

  def destroy
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.delete
        @alert = { :type => 'warning', :message => 'You just deleted a status.' }
        format.js { render 'hide_status', :object => @status }
      else
        @alert = { :type => 'danger', :message => 'Status message was not deleted.' }
        format.js { render 'app/shared/render_alert' }
      end
    end
  end

  private

  def status_params
    params.require(:status).permit(:text, :color)
  end

end
