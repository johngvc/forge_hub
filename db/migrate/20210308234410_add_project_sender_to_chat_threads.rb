class AddProjectSenderToChatThreads < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_threads, :project_sender_id, :integer
  end
end
