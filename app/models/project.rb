class Project < ApplicationRecord
  belongs_to :user
  has_many :participants, dependent: :delete_all
  has_many :join_requests, dependent: :delete_all
  has_one_attached :photo
end
# commit
