class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy, :new_message]

  def index
    @matches = []
    Match.all.each { |match| @matches << match if match.job.user.id == current_user.id || match.user.id == current_user.id }
    @matches
    @markers = @matches.map do |matche|
      if matche.job.user.id == current_user.id
      {
        lng: matche.job.longitude,
        lat: matche.job.latitude,
        infoWindow: { content: render_to_string(partial: "/users/map_window", locals: { find: matche.user }) }
      }
      else
        {
        lng: matche.job.longitude,
        lat: matche.job.latitude,
        infoWindow: { content: render_to_string(partial: "/users/map_window", locals: { find: matche.job.user }) }
      }
      end
    end
  end

  def show
    @match = Match.find(params[:id])


    @markers = [@match].map do |matche|
      if matche.job.user.id == current_user.id
      {
        lng: matche.job.longitude,
        lat: matche.job.latitude,
        infoWindow: { content: render_to_string(partial: "/users/map_window", locals: { find: matche.user }) }
      }
      else
        {
        lng: matche.job.longitude,
        lat: matche.job.latitude,
        infoWindow: { content: render_to_string(partial: "/users/map_window", locals: { find: matche.job.user }) }
      }
      end
    end
    @reviews = Review.where(match: @match)
    @match.messages.each { |message| message.update(read: true) if message.user_id != current_user.id}
  end

  def accept
    @match = Match.find(params["match_id"].to_i)
    @match.update(accepted: true)
  end

  def hire
    @match = Match.find(params["match_id"].to_i)
    @match.update(hired: true)
  end

  def finish
    @job = Job.find(params[:job_id].to_i)
    @job.update(finished?: true)
  end

  def new
    @user = User.find(params[:user])
    @jobs = []
    Job.all.each { |job| @jobs << job if job.user == current_user}
    @match = Match.new
  end

  def edit
  end

  def create
    set_user
    set_job
    @match = Match.new(user: @user, job: @job)
    if @match.valid?
      @match.save
      # Message.new(user: current_user, match: @match, body: "This is the start of your conversation")
      redirect_to match_path(@match)
    else
      render :new
    end
  end

  # def new_message
  #   @match.messages << params[:new_message]
  # end

  def update
    if @match.update(match_params)
      redirect_to root_path
      render :edit
    end
  end

  def destroy
    @match.destroy
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:user, :job, :hired, :accepted)
  end

  def set_user
    @user = User.find(params[:user])
  end
  def set_job
    @job = Job.find(params[:job])
  end
end
