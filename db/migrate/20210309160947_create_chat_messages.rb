class CreateChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_messages do |t|
      t.integer :user_sender_id, null: false
      t.integer :user_receiver_id, null: false
      t.references :project, foreign_key: true
      t.text :content_responding_to
      t.text :content, null: false
      t.datetime :sent_at, null: false
      t.timestamps
    end
  end
end
