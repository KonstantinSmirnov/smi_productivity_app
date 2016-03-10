class App::ProjectsController < AppController
  before_action :has_access?, except: [:create]

  def show
    @current_project = Project.find(params[:id])
  end

  def create
    @user = User.find(current_user)
    @project = @user.projects.build(title: params[:title], description: params[:description])

    respond_to do |format|
      if @project.save
        flash[:success] = 'Congratulations! New project has been created!'
        format.html { redirect_to app_project_path(@project) }
      else
        flash[:danger] = 'New project can not be created.'
        format.html { redirect_to app_dashboard_path}
      end
    end
  end

  def edit
    @current_project = Project.find(params[:id])
  end

  def update
    @current_project = Project.find(params[:id])

    respond_to do |format|
      if @current_project.update_attributes(project_params)
        flash.now[:success] = "Project info has been successfully updated."
        format.html { render 'edit' }
      else
        flash.now[:warning] = "Project info could not be updated due to a problem."
        format.html { render 'edit' }
      end
    end
  end

  def destroy
      if User.authenticate(current_user.email, params[:project][:password])
        @current_project = Project.find(params[:id])
        if current_user.id == @current_project.user_id
          @current_project.destroy
          flash[:success] = "Project has been successfully destroyed"
          render js: "window.location='#{app_dashboard_path}'"
        else
          flash.now[:danger] = "This is no your project, it can not be deleted."
          format.html { render 'edit' }
        end
      else
        respond_to do |format|
          flash.now[:danger] = "You entered an incorrect password"
          format.js { render 'delete_error_message' }
        end
      end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def has_access?
    if Project.exists?(params[:id])
      @current_project = Project.find(params[:id])
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
