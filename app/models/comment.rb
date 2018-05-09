class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :publication
  has_many :votes, dependent: :destroy
  has_many :vote_comments, dependent: :destroy
end
