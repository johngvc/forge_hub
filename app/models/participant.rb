class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :join_requests, dependent: :destroy
<<<<<<< HEAD
=======

>>>>>>> a530a6908e963250ea1d23177a66463c2be9398c
end
