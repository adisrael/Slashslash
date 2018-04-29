# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[show edit update destroy]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show; end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit; end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html do
          redirect_to @subscription, \
                      notice: 'Subscription was successfully created.'
        end
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json do
          render json: @subscription.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html do
          redirect_to @subscription, \
                      notice: 'Subscription was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json do
          render json: @subscription.errors,\
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html do
        redirect_to subscriptions_url,\
                    notice: 'Subscription was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:forum_id, :user_id)
  end
end
