class ChatMessage < ApplicationRecord
  # belongs_to :user_sender_id
  # belongs_to :user_receiver_id
  has_one :previous_message_id, class_name: :ChatMessage, foreign_key: true
end
