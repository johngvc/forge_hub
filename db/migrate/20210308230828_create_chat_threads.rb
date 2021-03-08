class CreateChatThreads < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_threads do |t|
      t.integer :user_sender_id, null: false
      t.integer :user_receiver_id
      t.references :project, foreign_key: true
      t.boolean :is_user_chat, default: true
      t.boolean :is_project_chat, default: false
      t.timestamps
    end
  end
end
