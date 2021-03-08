class AddColumnsToMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false
      t.datetime :sent_at, null: false
      t.references :chat_thread, null: false, foreign_key: true
      t.timestamps
    end
  end
end
