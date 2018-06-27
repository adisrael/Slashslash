# frozen_string_literal: true

require 'will_paginate'

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
    @popular_forums.reverse!
  end

  def top_forums
    @top_forums = Forum.order(:votos).reverse_order.paginate(page: params[:page], per_page: 5)
  end

  def top_publications
    @top_publications = Publication.order(:votos).reverse_order.paginate(page: params[:page], per_page: 5)
  end

  def top_users
    @top_users = User.order(:reputation).reverse_order.paginate(page: params[:page], per_page: 5)
  end

  def top_subscribed
    query = Subscription.select(:forum_id).group(:forum_id).count
    top_n = top query, Forum.all.length
    pop_forums = []
    top_n.each do |data|
      forum = Forum.find(data[0])
      forum.subscriptors = data[1]
      pop_forums << forum
    end
    @popular_forums = pop_forums.reverse.paginate(page: params[:page], per_page: 5)
  end

  def search_forum
    @home = false
    forums = Forum.search(params[:search_forum]).order(:created_at)
    @forums = forums.reverse_order.paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.html do
        render 'search_forum'
      end
    end
  end

  def search_publication
    @home = false
    pubs = Publication.search(params[:search_publication]).order(:created_at)
    @publications = pubs.reverse_order.paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.html do
        render 'search_publication'
      end
    end
  end

  def search_user
    @home = false
    users = User.search(params[:search_user]).order(:created_at).reverse_order
    @users = users.paginate(page: params[:page], per_page: 5)
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
