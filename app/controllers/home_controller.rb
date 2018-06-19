# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @top_forums = Forum.order(:votos).reverse_order
    @top_publications = Publication.order(:votos).reverse_order
    @top_users = User.order(:reputation).reverse_order 
    query = Subscription.select(:forum_id).group(:forum_id).count
    top3 = top query, 3
    @popular_forums = []
    top3.each do |data|
      forum = Forum.find(data[0])
      forum.subscriptors = data[1]
      @popular_forums << forum
    end
  end
  def top_forums
    @top_forums = Forum.order(:votos).reverse_order
  end
  def top_publications
    @top_publications = Publication.order(:votos).reverse_order
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

  private

  def top(hash, number)
    top = hash.sort_by { |_key, value| value }
    return top[-number..-1] if top.length >= number
    top
  end
end
