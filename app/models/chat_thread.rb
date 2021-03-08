class ChatThread < ApplicationRecord
  has_many :messages, dependent: :delete_all
  belongs_to :user, :foreign_key => 'user_sender_id'
  belongs_to :user, :foreign_key => 'user_receiver_id'
  belongs_to :project, :foreign_key => 'project_sender_id'
  belongs_to :project, :foreign_key => 'project_receiver_id'
end
