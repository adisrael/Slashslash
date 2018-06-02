class VoteCommentsController < ApplicationController
  def create
    data = vote_params #  user_id, comment_id
    result = VoteComment.where(user_id: data[:user_id],
                               comment_id: data[:comment_id],
                               positive: data[:positive]).to_a
    comment = Comment.find(data[:comment_id])
    respond_to do |format|
      if result.empty?
        @vote_comment = VoteComment.new(data)
        comment.votos += 1
        comment.user.reputation += 1
        if @vote_comment.save
          format.html do
            publication = balance(comment)
            redirect_to publication, notice: 'Voted.'
          end
        else
          root = comment
          root = comment.commentable while root.commentable_type != 'Publication'
          publication = root.commentable
          format.html do
            redirect_to publication, notice: 'Error ocurred'
          end
        end
      else
        root = result[0].comment
        root = comment.commentable while root.commentable_type != 'Publication'
        publication = root.commentable
        format.html do
          redirect_to publication, notice: 'Max Votes Reached'
        end
      end
    end
  end

  private

  def create_vote(comment); end

  def balance(comment)
    root = comment
    root = comment.commentable while root.commentable_type != 'Publication'
    publication = root.commentable
    inverse = VoteComment.where(user_id: @vote_comment.user_id,
                                comment_id: @vote_comment.comment_id,
                                positive: !@vote_comment.positive).to_a
    unless inverse.empty?
      inverse[0].destroy
      @vote_comment.destroy
    end
    publication
  end

  def vote_params
    params.require(:vote_comment).permit(:user_id, :comment_id, :positive)
  end
end
