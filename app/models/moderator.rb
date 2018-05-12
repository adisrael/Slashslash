class Moderator < ApplicationRecord
  belongs_to :user
  belongs_to :forum

  before_create :default_role

  private

  def default_approved
    self.approved ||= false
  end
end
