# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    # Require current password if user is trying to change password.
    return super if current_user.facebook_registered.zero?
    # Allows user to update registration information without password.
    resource.update_without_password(params)
  end

  private

  def sign_up_params
    params
      .require(:user)
      .permit(:firstName,\
              :lastName, :userName, :email, :password, :password_confirmation)
  end

  def account_update_params
    params
      .require(:user)
      .permit(:firstName, :lastName, :userName, \
              :email, :password, :password_confirmation, :current_password)
  end
end
