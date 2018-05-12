class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :publications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :vote_comments, dependent: :destroy
  has_many :moderators, dependent: :destroy
  has_many :modered_forums, through: :moderators, source: :forum

  before_create :default_role
  def default_role
    self.role ||= 2
  end
end
