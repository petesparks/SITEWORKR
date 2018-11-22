class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    Job.all
  end

  def search
    @jobs = []
    search = Geocoder.search(current_user.address)
    current_user.area_of_influence = 3 if current_user.area_of_influence.nil?
    jobs_by_skill = Job.where("skill ILIKE ?", "%#{current_user.skill}%")

    if search == []
      @jobs = jobs_by_skill
    else
      jobs_by_skill.each do |job|
        location = Geocoder.search(job.location)
        unless location == []
          @jobs << job if Geocoder::Calculations.distance_between([search[0].latitude, search[0].longitude], [location[0].latitude, location[0].longitude]) <= current_user.area_of_influence
        end
      end
    end
    @finds = @jobs.reject do |job|
        location = Geocoder.search(job.location)
        location[0].latitude.nil? || location[0].longitude.nil?
    end

    @markers = @finds.map do |find|
      {
        lng: find.longitude,
        lat: find.latitude,
        infoWindow: { content: render_to_string(partial: "/jobs/map_window", locals: { find: find }) }

      }
    end
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
      redirect_to search_users_path(search: @job.skill, search2: @job.location)
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
    params.require(:job).permit(:user, :title, :location, :start_date, :end_date, :rate, :skill)
  end
end
