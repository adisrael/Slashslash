class VoteController < ApplicationController
  def create
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :publication_id, :comment_id)
  end
end
