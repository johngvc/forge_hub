class AddStatusToParticipant < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :status, :string, null: false
  end
end
