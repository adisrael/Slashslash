# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @forums = Forum.all
  end

  def search_forum
    @forums = Forum.all
    @forums = if params[:search]
                Forum.search(params[:search]).order('created_at DESC')
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
    @publications = Publication.all
    @publications = if params[:search]
                      Publication.search(params[:search]).order('created_at DESC')
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
