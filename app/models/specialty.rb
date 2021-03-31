class Specialty < ApplicationRecord
  has_many :user_specialties, dependent: :delete_all
  has_many :users, through: :user_specialties
  validates :name, inclusion: { in: %w[Code Art Sound Design Business Finance Marketing Law],
                                message: "%{value} is not a valid project status" }
end
