class Project < ApplicationRecord
  belongs_to :user
  has_many :project_participants
  has_many :users, through: :project_participants
end
