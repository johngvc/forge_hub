class AddMessageToJoinRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :join_requests, :content, :text, null:false
  end
end
