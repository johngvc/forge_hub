class CreateChatThreads < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_threads do |t|

      t.timestamps
    end
  end
end
