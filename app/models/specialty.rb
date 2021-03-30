class Specialty < ApplicationRecord
  has_many :user_specialties, dependent: :delete_all
  has_many :users, through: :user_specialties
end
