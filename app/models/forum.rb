class Forum < ApplicationRecord
  has_many :publications, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
end
