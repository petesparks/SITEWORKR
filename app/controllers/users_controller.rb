class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :search]

  def index
    @users = User.all
  end

  def show

  end

  def new
    @user = User.new
  end

  def search
    @users = User.where("skill ILIKE '%#{params[:search]}%'")
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :address, :area_of_influence, :skill, :rate, :email, :password)
  end

end
