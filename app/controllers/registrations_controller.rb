class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:name, :password, :email, :company)
  end

  def account_update_params
    params.require(:user).permit(:name, :current_password, :password, :password_confirmation, :address, :area_of_influence, :skill, :rate, :about_me, :certificates, :experience, :photo, :company)
  end
end
