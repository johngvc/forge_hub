class CreateChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_messages do |t|
      t.references :user_sender, null: false
      t.references :user_receiver,  null: false
      t.text :content_responding_to
      t.text :content, null: false
      t.datetime :sent_at, null: false
      t.timestamps
    end
  end
end
