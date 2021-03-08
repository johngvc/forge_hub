class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :status, inclusion: { in: %w(invitee member founder cofounder),
    message: "%{value} is not a valid project status" }
end
