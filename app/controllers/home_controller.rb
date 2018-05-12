# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def search_forum
    @home = false
    @forums = Forum.all
    @forums = Forum.search(params[:search_forum]).order('created_at DESC')
    respond_to do |format|
      format.html do
        render 'index'
      end
    end
  end

  def search_publication
    @home = false
    @publications = Publication.all
    @publications = Publication.search(params[:search_publication])
    respond_to do |format|
      format.html do
        render 'index'
      end
    end
  end

  def search_user
    @home = false
    @users = User.all
    @users = User.search(params[:search_user])
    respond_to do |format|
      format.html do
        render 'index'
      end
    end
  end

end
