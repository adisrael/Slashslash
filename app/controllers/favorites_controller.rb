class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(favorite_params)

    respond_to do |format|
      if @favorite.save
        format.html do
          redirect_to @favorite.publication, notice: 'Starred'
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

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    favorite = Favorite.where(favorite_params).take
    publication = favorite.publication
    favorite.destroy
    respond_to do |format|
      format.html do
        redirect_to publication, notice: 'Unstarred'
      end
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def favorite_params
    params.require(:favorite).permit(:publication_id, :user_id)
  end
end
