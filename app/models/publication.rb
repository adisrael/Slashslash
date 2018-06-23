class Publication < ApplicationRecord
  belongs_to :user
  belongs_to :forum
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one :poll, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  before_create :default_votos

  def default_votos
    self.votos = 0
  end


  def self.search(search)
    where('title ILIKE ? OR content ILIKE ?', "%#{search}%", "%#{search}%")
  end
end
