class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :join_requests, dependent: :delete_all
  validates :status, inclusion: { in: %w(invitee member founder),
    message: "%{value} is not a valid project status" }
end
