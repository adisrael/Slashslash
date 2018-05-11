# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def search_forum
    @home = false
    @forums = Forum.all
    @forums = Forum.search(params[:search_forum]).order('created_at DESC')
    @forums.each do |forum|
      votos = 0
      forum.publications.each do |publication|
        votos += publication.votos
      end
      forum.total_votes = votos
    end
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
end
