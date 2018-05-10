# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @forums = Forum.all
  end

  def search
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
end
