class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!

  # before_action :configure_permitted_parameters, if: :devise_controller?

  # def configure_permitted_parameters
  #   # For additional fields in app/views/devise/registrations/new.html.erb
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

  #   # For additional in app/views/devise/registrations/edit.html.erb
  #   # devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :area_of_influence, :rate, :skill, :about_me, :certificates, :experience, :photo])
  # end

  def after_sign_in_path_for(resource_or_scope)
    Job.create!(title: "Query", location: "not defined", skill: "not specified", user_id: current_user.id)
    user_path(current_user)
  end

  def after_sign_up_path_for(resource_or_scope)
    user_path(current_user)
  end

end
