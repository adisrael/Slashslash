class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :publication
  before_create :update_votes

  private

  def update_votes
    point = positive ? 1 : -1
    publication.votos += point
    publication.forum.votos += point
    publication.user.reputation += point
    publication.save && publication.forum.save && publication.user.save
  end
end
