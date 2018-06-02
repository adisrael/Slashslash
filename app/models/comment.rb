class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :vote_comments, dependent: :destroy
  before_create :default_votos

  def default_votos
    self.votos = 0
  end
end
