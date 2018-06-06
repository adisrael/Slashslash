# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy upload]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html do
          redirect_to @user, notice: 'User was successfully created.'
        end
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html do
          redirect_to @user, notice: 'User was successfully updated.'
        end
        format.json do
          render :show, status: :ok, location: @user
        end
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        redirect_to users_url, notice: 'User was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def upload
    uploaded_io = params[:picture]
    path = uploaded_io.tempfile.path
    save_screenshot_to_s3(path, 'folder', 1)
    redirect_to @user
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:userName, :firstName, :lastName, :role, :avatar, :picture)
  end

  def save_screenshot_to_s3(image_location, folder_name, _user_id)
    s3 = Aws::S3::Resource.new(region: 'sa-east-1', access_key_id: ENV['ACCESS_KEY_ID'], secret_access_key: ENV['SECRET_ACCESS_KEY'])
    bucket_name = 'slash-bucket'
    key = folder_name.to_s + '/' + File.basename(image_location)
    object = s3.bucket(bucket_name).object(key)
    object.upload_file(image_location)
    @user.image = object.public_url.to_s
    @user.save
  end
end
