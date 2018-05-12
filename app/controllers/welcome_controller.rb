# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    redirect_to home_path if user_signed_in?
  end
end
