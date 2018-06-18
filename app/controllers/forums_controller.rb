# frozen_string_literal: true

class ForumsController < ApplicationController
  before_action :set_forum, only: %i[show edit update destroy]

  # GET /forums
  # GET /forums.json
  def index
    @forums = Forum.all
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
    current = Subscription.where(forum: @forum, user: current_user).take
    @subscription = if current.nil?
                      Subscription.new
                    else
                      current
                    end
  end

  # GET /forums/new
  def new
    @forum = Forum.new
  end

  # GET /forums/1/edit
  def edit; end

  # POST /forums
  # POST /forums.json
  def create
    @forum = Forum.new(forum_params)
    @forum.votos = 0
    respond_to do |format|
      if @forum.save
        format.html do
          redirect_to @forum, notice: 'Forum was successfully created.'
        end
        format.json { render :show, status: :created, location: @forum }
      else
        format.html { render :new }
        format.json do
          render json: @forum.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /forums/1
  # PATCH/PUT /forums/1.json
  def update
    respond_to do |format|
      if @forum.update(forum_params)
        format.html do
          redirect_to @forum, notice: 'Forum was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @forum }
      else
        format.html { render :edit }
        format.json do
          render json: @forum.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum.destroy
    respond_to do |format|
      format.html do
        redirect_to forums_url, notice: 'Forum was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def new_publication
    @publication = Publication.new
    @forum_id = params[:id]
    render 'publications/new'
  end

  def new_publication_image
    @publication = Publication.new
    @forum_id = params[:id]
    render 'publications/new_image'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_forum
    @forum = Forum.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def forum_params
    params.require(:forum).permit(:title, :description)
  end

  # GET forums/1/new_publication
end
