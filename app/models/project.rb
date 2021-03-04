class Project < ApplicationRecord
  belongs_to :user
  has_many :participants
  has_many :users, through: :participants
  has_one_attached :photo
end
# commit
