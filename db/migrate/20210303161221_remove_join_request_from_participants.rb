class RemoveJoinRequestFromParticipants < ActiveRecord::Migration[6.0]
  def change
    remove_reference :participants, :join_requests, foreign_key: true
  end
end
