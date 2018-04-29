# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @forums = Forum.all
  end
end
