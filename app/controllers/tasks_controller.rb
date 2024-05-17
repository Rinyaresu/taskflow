class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_project, only: %i[index new create edit update show destroy]

  # GET /tasks or /tasks.json
  def index
    if @project
      @tasks = @project.tasks
    elsif current_user&.admin?
      @tasks = Task.all
    else
      @tasks = Task.none
      redirect_to projects_path, notice: 'You are not authorized to access this page'
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @task = @project.tasks.build
  end

  # GET /tasks/1/edit
  def edit
    @task = @project.tasks.find(params[:id])
  end

  # POST /tasks or /tasks.json
  def create
    @task = @project.tasks.build(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    authorize @task
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    authorize @task
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    project_id = params[:project_id] || params.dig(:task, :project_id)
    @project = Project.find_by(id: project_id)
    return if @project

    redirect_to projects_path, notice: 'Project not found'
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :user_id, :project_id)
  end
end
