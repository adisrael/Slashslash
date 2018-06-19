class Poll < ApplicationRecord
  attr_accessor :total
  has_many :poll_options, dependent: :destroy
  has_many :poll_votes, dependent: :destroy
  belongs_to :publication
end
