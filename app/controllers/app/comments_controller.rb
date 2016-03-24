class App::CommentsController < AppController
  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build(text: params[:text])
    @comment.user = User.find(current_user)
    @current_project = Project.find(params[:project_id])

    respond_to do |format|
      if @comment.save
        format.js { render 'add_comment', :object => @comment }
      else
        @alert = { :type => 'danger', :message => 'Comment can not be added.'}
        format.js { render 'app/shared/render_alert' }
      end
    end
  end

  def update
    @current_project = Project.find(params[:project_id])
    @comment = Comment.find(params[:id])
    @task = @comment.task

    respond_to do |format|
      if @comment.update_attributes(comment_params)
        @alert = { :type => 'success', :message => 'Comment has been successfully updated.'}
        format.js { render 'update_comment' }
      else
        @alert = { :type => 'danger', :message => 'Comment can not be updated' }
        format.js { render 'app/shared/render_alert' }
      end
    end
  end

  def edit
    @current_project = Project.find(params[:project_id])
    @comment = Comment.find(params[:id])
    @task = @comment.task
    respond_to do |format|
      format.js { render 'edit_comment', :object => @comment }
    end
  end

  def cancel_edit
    @current_project = Project.find(params[:project_id])
    @comment = Comment.find(params[:id])
    @task = @comment.task
    respond_to do |format|
      format.js { render 'update_comment' }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment_id = @comment.id

    respond_to do |format|
      if @comment.delete
        @alert = { :type => 'warning', :message => 'You just deleted a comment.' }
        format.js { render 'hide_comment', :object => @comment }
      else
        @alert = { :type => 'danger', :message => 'Comment was not deleted.' }
        format.js { render 'app/shared/render_alert' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
