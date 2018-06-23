# frozen_string_literal: true

class WelcomeController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def index
    redirect_to home_path if user_signed_in?
  end
end
