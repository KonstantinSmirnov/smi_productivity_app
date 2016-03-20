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
end
