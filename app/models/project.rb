class Project < ApplicationRecord
  belongs_to :user
  has_many :participants
  has_many :users, through: :participants
  has_one_attatched :photo
end
# commit
