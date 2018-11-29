class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :search]

  def index
    @users = User.all
    @finds = @users.where.not(latitude: nil, longitude: nil)

    @markers = @finds.map do |find|
      {
        lng: find.longitude,
        lat: find.latitude,
        infoWindow: { content: render_to_string(partial: "/users/map_window", locals: { find: find }) }
      }
    end
  end

  def show
    matches = @user.matches
    @booked_dates = matches.map do |match|
      {
        from: match.job.start_date,
        to: match.job.end_date
      }
    end
  end


  # def new
  #   @user = User.new
  # end

  def search
    @users = []
    search = Geocoder.search(params[:search2])

    users_by_skill = User.where("skill ILIKE ?", "%#{params[:search]}%")
    if search == []
      @users = users_by_skill
    else
      users_by_skill.each do |user|
        address = Geocoder.search(user.address)
        unless address == []
          user.area_of_influence = 3 if user.area_of_influence.nil?
          @users << user if Geocoder::Calculations.distance_between([search[0].latitude, search[0].longitude], [address[0].latitude, address[0].longitude]) <= user.area_of_influence && !user.company
        end
      end
    end

    @finds = @users.reject do |user|
      address = Geocoder.search(user.address)
      unless address == []
        address[0].latitude.nil? || address[0].longitude.nil?
      end
    end

    @markers = @finds.map do |find|
      {
        lng: find.longitude,
        lat: find.latitude,
        infoWindow: { content: render_to_string(partial: "/users/map_window", locals: { find: find }) }

      }
    end
  end

  def edit
  end

  # def create
  #   @user = User.new(user_params)

  #   if @user.valid?
  #     @user.save
  #     redirect_to user_path(@user)
  #   else
  #     render :new
  #   end
  # end

  # def update
  #   if @user.update(user_params)
  #     redirect_to user_path(@user)
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :address, :area_of_influence, :skill, :rate, :email, :password, :about_me, :certificates, :experience, :photo, :company, :banner)
  end

end
