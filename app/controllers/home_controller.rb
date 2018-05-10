# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def search_forum
    @home = false
    @forums = Forum.all
    @forums = if params[:search_forum]
                Forum.search(params[:search_forum]).order('created_at DESC')
              else
                Forum.all.order('created_at DESC')
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
    @publications = if params[:search_publication]
                      Publication.search(params[:search_publication]).order('created_at DESC')
                    else
                      Publication.all.order('created_at DESC')
                    end
    respond_to do |format|
      format.html do
        render 'index'
      end
    end
  end
end
