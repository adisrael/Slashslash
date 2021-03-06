# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
      %i[username email password password_confirmation remember_me avatar avatar_cache])
    devise_parameter_sanitizer.permit(:account_update, keys:
      %i[username password password_confirmation current_password avatar avatar_cache remove_avatar])
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || :home
  end
end
