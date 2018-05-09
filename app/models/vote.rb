class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :publication
  belongs_to :comment
end
