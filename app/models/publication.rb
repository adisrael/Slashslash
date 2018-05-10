class Publication < ApplicationRecord
  belongs_to :user
  belongs_to :forum
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  def self.search(search)
    where('title ILIKE ? OR content ILIKE ?', "%#{search}%", "%#{search}%")
  end
end
