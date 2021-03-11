class AddNewMessageBooleanToChatMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_messages, :is_new_message, :boolean, default: true
  end
end
