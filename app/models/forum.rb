class Forum < ApplicationRecord
  has_many :publications
  has_many :subscriptions
end
