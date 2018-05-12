class RequestsController < ApplicationController
  def accept
    request = Moderator.find(params[:id])
    request.approved = true
    redirect_to action: 'show' if request.save
  end

  def reject
    Moderator.destroy(params[:id])
    redirect_to action: 'show'
  end

  def show
    @requests = Moderator.where(approved: false)
  end

  def resign
    moderator = Moderator.where(user_id: params[:user_id], forum_id: params[:forum_id]).take
    Moderator.destroy(moderator.id)
    redirect_to forum_path(params[:forum_id])
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
