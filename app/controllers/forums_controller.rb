# frozen_string_literal: true

class ForumsController < ApplicationController
  before_action :set_forum, only: %i[show edit update destroy image_upload]

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

  def image_upload
    @publication = Publication.new(
      content: params[:content],
      title: params[:title],
      user: current_user,
      forum: @forum
    )
    @publication.votos = 0
    uploaded_io = params[:picture]
    path = uploaded_io.tempfile.path
    save_screenshot_to_s3(path, 'folder')
    redirect_to @publication
  end

  def new_publication_poll
    @publication = Publication.new
    @poll = Poll.new
    render 'publications/new_poll'
  end

  def create_poll
    forum = Forum.find(params[:id])
    publication = Publication.new(title: params[:publication_title], forum: forum)
    publication.user = current_user
    publication.votos = 0
    publication.content_type = 'poll'
    publication.save
    poll = Poll.new(question: params[:question])
    poll.publication = publication
    poll.save
    params.each do |k, v|
      next unless k.split('_')[0] == 'option'
      option = PollOption.new(text: v)
      option.votos = 0
      option.poll = poll
      option.save
    end
    poll.poll_options.each do |option|
    end
    redirect_to publication
  end

  def new_publication_link
    @publication = Publication.new
    render 'publications/new_link'
  end

  def create_link
    forum = Forum.find(params[:id])
    publication = Publication.new(title: params[:publication_title], forum: forum)
    publication.content = params[:url]
    publication.content_type = 'link'
    publication.user = current_user
    publication.save
    redirect_to publication
  end

  private

  def save_screenshot_to_s3(image_location, folder_name)
    s3 = Aws::S3::Resource.new(region: 'sa-east-1')
    bucket_name = 'slash-bucket'
    key = folder_name.to_s + '/' + File.basename(image_location)
    object = s3.bucket(bucket_name).object(key)
    object.upload_file(image_location)
    @publication.image = object.public_url.to_s
    @publication.save
  end

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
