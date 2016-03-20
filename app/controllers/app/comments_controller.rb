class App::CommentsController < AppController
    def create
       @task = Task.find(params[:task_id])
       @comment = @task.comments.build(text: params[:text])
       
       respond_to do |format|
          if @comment.save
              format.html { redirect_to root_path }
          end
       end
    end
end