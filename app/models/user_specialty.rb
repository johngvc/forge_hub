class UserSpecialty < ApplicationRecord
  belongs_to :user
  belongs_to :specialty
  validates :user, uniqueness: { scope: :specialty,
                                 message: "You can't add several times same tag" }
end
