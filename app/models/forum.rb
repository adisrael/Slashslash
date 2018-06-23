class Forum < ApplicationRecord
  attr_accessor :subscriptors
  has_many :publications, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :moderators
  has_many :moderator_users, through: :moderators, source: :user
  has_many :votes, dependent: :destroy

  def self.search(search)
    where('title ILIKE ? OR description ILIKE ? ', "%#{search}%", "%#{search}%")
  end
end
