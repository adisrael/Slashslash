class VoteCommentController < ApplicationController
  def create
    data = vote_params #  user_id, comment_id
    result = VoteComment.where(user_id: data[:user_id],\
                               comment_id: data[:comment_id]).to_a
    comment = Comment.find(data[:comment_id])
    respond_to do |format|
      if result.empty?
        @vote_comment = VoteComment.new(data)
        comment.votos += 1
        if @vote_comment.save && comment.save
          format.html do
            redirect_to publication, notice: 'UpVoted.'
          end
        else
          format.html do
            redirect_to publication, notice: 'Error ocurred'
          end
        end
      else
        format.html do
          redirect_to publication, notice: 'Already voted this commentary'
        end
      end
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :comment_id)
  end
end
