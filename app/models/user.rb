class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :publications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :vote_comments, dependent: :destroy
  has_many :moderators, dependent: :destroy
  has_many :moderated_forums, through: :moderators, source: :forum
  has_many :forums, through: :subscriptions
  has_many :favorites, dependent: :destroy
  has_many :favorite_publications, through: :favorites, source: :publication
  has_many :poll_vote, dependent: :destroy

  before_create :default_role
  before_create :default_reputation

  def self.search(search)
    where('userName ILIKE ? OR lastName ILIKE ? OR firstName ILIKE ?',
          "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def default_role
    self.role ||= 2
  end

  def accepted(forum_id)
    moderators.each do |m|
      return m.approved if m.forum_id == forum_id
    end
    false
  end

  def default_reputation
    self.reputation ||= 0
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end


end
