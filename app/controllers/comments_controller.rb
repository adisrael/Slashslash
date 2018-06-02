# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show; end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments
  # POST /comments.json
  def create
    current_user.reputation += 1
    if comment_params[:commentable_type] == 'publication'
      publication = Publication.find(comment_params[:commentable_id])
      if publication.comments.create(comment_params)
        redirect_to publication, notice: 'Comment added'
      end
    elsif comment_params[:commentable_type] == 'comment'
      comment = Comment.find(comment_params[:commentable_id])
      root = comment
      root = comment.commentable while root.commentable_type != 'Publication'
      publication = root.commentable
      redirect_to publication, notice: 'Comment added' if comment.comments.create(comment_params)
    end
    update_votes(publication)
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html do
          redirect_to @comment, notice: 'Comment was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json do
          render json: @comment.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    publication = @comment.publication
    @comment.destroy
    respond_to do |format|
      format.html do
        redirect_to publication, notice: 'Comment was successfully deleted.'
      end
      format.json { head :no_content }
    end
  end

  private

  def update_votes(publication)
    publication.votos += 1
    publication.forum.votos += 1
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content, :user_id, :commentable_id, :commentable_type)
  end
end
