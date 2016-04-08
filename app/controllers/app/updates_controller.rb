class App::UpdatesController < AppController
  def index
    @current_project = Project.find(params[:project_id])
    @updates = @current_project.updates.reverse
    @statuses = Update.select(:status).distinct
  end
  
  def create
    @current_project = Project.find(params[:project_id])
    @update = @current_project.updates.build(text: params[:text], status: params[:status])
    @update.user = User.find(current_user)
    
    respond_to do |format|
      if @update.save
        format.js { render 'add_update', :object => @update }
      else
        @alert = { :type => 'danger', :message => 'Project update can not be added.' }
        format.js { render 'app/shared/render_alert' }
      end
    end
  end
  
  def edit
    @current_project = Project.find(params[:project_id])
    @update = Update.find(params[:id])
    respond_to do |format|
      format.js { render 'edit_update', :object => @update }
    end
  end
  
  def cancel_edit
    @current_project = Project.find(params[:project_id])
    @update = Update.find(params[:id])
    respond_to do |format|
      format.js { render 'update_update' }
    end
  end
  
  def update
    @current_project = Project.find(params[:project_id])
    @update = Update.find(params[:id])
    
    respond_to do |format|
      if @update.update_attributes(update_params)
        @alert = { :type => 'success', :message => 'Status has been successfully updated.'}
        format.js { render 'update_update' }
      else
        @alert = { :type => 'danger', :message => 'Status has not been updated.' }
        format.js { render 'update_update' }
      end
    end
  end
  
  def destroy
    @update = Update.find(params[:id])
    
    respond_to do |format|
      if @update.delete
        @alert = { :type => 'warning', :message => 'You just deleted the update.' }
        format.js { render 'hide_update', :object => @update }
      else
        @alert = { :type => 'danger', :message => 'Update was not deleted.' }
        format.js { render 'app/shared/render_alert' }
      end
    end
  end
  
  private
  
  def update_params
    params.require(:update).permit(:text, :status)
  end

end
