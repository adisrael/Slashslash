# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def create
    @subscription = Subscription.new(subscription_params.except(:publication_id))

    unless subscription_params[:publication_id].nil?
      @subscription.save
      publication = Publication.find(subscription_params[:publication_id])
      return redirect_to publication
    end

    respond_to do |format|
      if @subscription.save
        format.html do
          redirect_to @subscription.forum, notice: 'Subscribed'
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

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    subscription = Subscription.where(subscription_params.except(:publication_id)).take
    forum = subscription.forum
    subscription.destroy
    unless subscription_params[:publication_id].nil?
      publication = Publication.find(subscription_params[:publication_id])
      return redirect_to publication
    end
    respond_to do |format|
      format.html do
        redirect_to forum, notice: 'Unsubscribed'
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
    params.require(:subscription).permit(:forum_id, :user_id, :publication_id)
  end
end
