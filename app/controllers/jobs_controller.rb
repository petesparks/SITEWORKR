class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = []
    Job.all.each { |job| @jobs << job if job.user == current_user}
    @jobs
  end

  def show
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    if @job.valid?
      @job.save
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def update
    if @job.update(job_params)
      redirect_to job_path(@job)
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:user, :title, :location, :start_date, :duration, :rate, :skill)
  end
end
