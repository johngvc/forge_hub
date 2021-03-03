class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :join_requests

end
