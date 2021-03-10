class ChangeUserSenderInChatThreads < ActiveRecord::Migration[6.0]
  def change
    remove_column :chat_threads, :user_sender_id, :integer
    add_column :chat_threads, :user_sender_id, :integer
  end
end
