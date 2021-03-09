class RemoveContentRespondingToFromChatMessages < ActiveRecord::Migration[6.0]
  def change
    remove_column :chat_messages, :content_responding_to
  end
end
