class AddPreviousMessageIdToChatMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_messages, :previous_message_id, :integer
  end
end
