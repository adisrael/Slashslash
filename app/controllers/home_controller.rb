# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @top_forums = Forum.order(:votos).reverse_order.take(3)
    @top_publications = Publication.order(:votos).reverse_order.take(3)
    # @popular_forums = Subscription.select(:forum_id).group(:forum_id).count
  end

  def search_forum
    @home = false
    @forums = Forum.search(params[:search_forum]).order(:votos).reverse_order
    respond_to do |format|
      format.html do
        render 'search_forum'
      end
    end
  end

  def search_publication
    @home = false
    @publications = Publication.search(params[:search_publication])
    respond_to do |format|
      format.html do
        render 'search_publication'
      end
    end
  end

  def search_user
    @home = false
    @users = User.search(params[:search_user])
    respond_to do |format|
      format.html do
        render 'search_user'
      end
    end
  end
end
