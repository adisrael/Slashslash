class Poll < ApplicationRecord
  has_many :poll_option, dependent: :destroy
  has_many :poll_vote, dependent: :destroy
end
