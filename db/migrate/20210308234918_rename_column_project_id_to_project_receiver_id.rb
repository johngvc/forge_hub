class RenameColumnProjectIdToProjectReceiverId < ActiveRecord::Migration[6.0]
  def change
    rename_column :chat_threads, :project_id, :project_receiver_id
  end
end
