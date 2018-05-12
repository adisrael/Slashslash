class RequestsController < ApplicationController
  def accept
    request = Moderator.find(params[:id])
    request.approved = true
    redirect_to action: 'show' if request.save
  end

  def reject; end

  def show
    @requests = Moderator.where(approved: false)
  end

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
end
