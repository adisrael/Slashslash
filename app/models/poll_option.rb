class PollOption < ApplicationRecord
  belongs_to :poll
  has_many :poll_vote, dependent: :destroy
end
