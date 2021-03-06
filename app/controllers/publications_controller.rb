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
    subscriptors = Subscription.where(forum: @publication.forum).count
    @publication.forum.subscriptors = subscriptors
    if @publication.content_type == 'poll'
      poll = @publication.poll
      poll.total = 0
      poll.poll_options.each do |option|
        poll.total += option.votos
      end
    end
    @time = Time.zone.now
    if user_signed_in?
      @comment = Comment.new
      vote = Vote.where(user_id: current_user.id,
                        publication_id: @publication.id).to_a
      @vote = if vote.empty?
                Vote.new
              else
                vote[0]
              end
      @vote_comment = VoteComment.new
      current = Favorite.where(publication: @publication, user: current_user).take
      @favorite = if current.nil?
                    Favorite.new
                  else
                    current
                  end
    end
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
    @publication.votos = 0
    @publication.forum.votos += 1
    respond_to do |format|
      current_user.reputation += 1
      if @publication.save && current_user.save && @publication.forum.save
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
    forum = @publication.forum
    @publication.destroy
    respond_to do |format|
      format.html do
        redirect_to forum,\
                    notice: 'Publication was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def poll_vote
    poll = Poll.find(params[:poll_id])
    option = PollOption.find(params[:vote])
    option.votos += 1
    option.save
    vote = PollVote.new(poll: poll, poll_option: option, user: current_user)
    vote.save
    redirect_to poll.publication
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
