# frozen_string_literal: true

class PublicationsController < ApplicationController
  before_action :set_publication, only: %i[show edit update destroy]

  # GET /publications
  # GET /publications.json
  def index
    @publications = Publication.all
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
    @comment = Comment.new
  end

  # GET /publications/new
  def new
    @publication = Publication.new
  end

  # GET /publications/1/edit
  def edit; end

  # POST /publications
  # POST /publications.json
  def create
    @publication = Publication.new(publication_params)

    respond_to do |format|
      if @publication.save
        format.html do
          redirect_to @publication, \
                      notice: 'Publication was successfully created.'
        end
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new }
        format.json do
          render json: @publication.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html do
          redirect_to @publication,\
                      notice: 'Publication was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit }
        format.json do
          render json: @publication.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html do
        redirect_to publications_url,\
                    notice: 'Publication was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_publication
    @publication = Publication.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def publication_params
    params.require(:publication).permit(:title, :content, :user_id, :forum_id)
  end
end
