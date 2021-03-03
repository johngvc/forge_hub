class Project < ApplicationRecord
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  has_many :join_requests, dependent: :destroy
end
# commit
