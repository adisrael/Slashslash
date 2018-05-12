class Moderator < ApplicationRecord
  belongs_to :user
  belongs_to :forum

  before_create :default_approved

  private

  def default_approved
    self.approved ||= false
  end
end
