class ChatMessage < ApplicationRecord
  belongs_to :user_sender_id, class_name: :User, foreign_key: true
  belongs_to :user_receiver_id, class_name: :User, foreign_key: true
  belongs_to :project
end
