class VoteComment < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  before_create :update_votes

  private

  def update_votes
    point = positive ? 1 : -1
    comment.votos += point
    comment.user.reputation += point
    comment.save && comment.user.save
  end
end
