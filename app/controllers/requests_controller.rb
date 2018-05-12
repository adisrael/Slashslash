class RequestsController < ApplicationController
  def apply
    forum = Forum.find(params[:forum_id])
    user = User.find(params[:user_id])
    moderator = Moderator.new(user: user, forum: forum)
    if moderator.save
      respond_to do |format|
        format.html { redirect_to forum }
      end
    end
  end

  def accept; end

  def reject; end

  def show
    @requests = Moderator.where(approved: false)
  end
end
