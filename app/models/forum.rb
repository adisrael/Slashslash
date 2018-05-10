class Forum < ApplicationRecord
  has_many :publications, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  def self.search(search)
    where('title ILIKE ? OR description ILIKE ? ', "%#{search}%", "%#{search}%")
  end
end
