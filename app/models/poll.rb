class Poll < ApplicationRecord
  has_many :poll_option, dependent: :destroy
  has_many :poll_vote, dependent: :destroy
  belongs_to :publication
end
