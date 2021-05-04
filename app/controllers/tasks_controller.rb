class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # added by drtoon # 209  
  #before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user!

  # GET /tasks or /tasks.json
  def index
    if params[:search]
      q = params[:search].tr('.','')
      redirect_to "/search/#{q}"
    end
    @tasks = Task.page(params[:page])
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    if params[:q]
      q = params[:q]
      res = []
      @tasks = Task.where(["LOWER(issue||category||ref||tags||solution) LIKE ?", "%#{q.downcase}%"])
      @tasks = @tasks.page(params[:page])
      ids1 = @tasks.to_a.map(&:id)

      @tasks_rich = Task.joins(:action_text_rich_text).where("LOWER(action_text_rich_texts.body) LIKE ?", "%#{q.downcase}%")
      ids2 = @tasks_rich.map(&:id)

      ids = ids1+ids2

      @tasks = Task.where(["id IN (?)", ids.uniq]).page(params[:page])

      render "index"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:issue, :category, :ref, :tags, :solution, :content)
    end

end
