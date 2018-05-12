class Forum < ApplicationRecord
  has_many :publications, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :moderator_users, through: :moderators, source: :user
  attr_accessor :total_votes
  def self.search(search)
    where('title ILIKE ? OR description ILIKE ? ', "%#{search}%", "%#{search}%")
  end
end
