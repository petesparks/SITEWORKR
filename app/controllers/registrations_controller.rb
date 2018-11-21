class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:name, :password, :email, :company)
  end

  def account_update_params
    params.require(:user).permit(:name, :current_password, :password, :password_confirmation, :address, :area_of_influence, :skill, :rate, :about_me, :certificates, :experience, :photo, :company)
  end

  def after_sign_up_path_for(resource_or_scope)
    Job.create!(title: "Query", location: "not defined", skill: "not specified", user_id: current_user.id)
    user_path(current_user)
  end

  def after_update_path_for(resource_or_scope)
    user_path(current_user)
  end
end
