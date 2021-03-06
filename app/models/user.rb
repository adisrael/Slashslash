class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

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
  before_create :default_facebook_registered

  validates :userName, uniqueness: true

  def self.search(search)
    where('userName ILIKE ? OR lastName ILIKE ? OR firstName ILIKE ?',
          "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def default_role
    self.role ||= 2
  end

  def default_facebook_registered
    self.facebook_registered = 0 unless facebook_registered == 1
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
      if (data = session['devise.facebook_data']) && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.userName = auth.info.name.downcase.tr(' ', '.') # assuming the user model has a name
      user.firstName = auth.info.name.match(' ').pre_match   # assuming the user model has a name
      user.lastName = auth.info.name.match(' ').post_match   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.facebook_registered = 1
    end
  end
end
