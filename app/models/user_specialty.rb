class UserSpecialty < ApplicationRecord
  belongs_to :user
  belongs_to :specialty
end
