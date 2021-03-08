class Project < ApplicationRecord
  belongs_to :user
  has_many :participants, dependent: :delete_all
  has_many :join_requests, dependent: :delete_all
  has_one_attached :photo


  validates :name, presence: true, length: { maximum: 22 }
  validates :description, presence: true, length: { maximum: 135 }

end
