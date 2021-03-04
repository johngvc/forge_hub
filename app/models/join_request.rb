class JoinRequest < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :participant
end
