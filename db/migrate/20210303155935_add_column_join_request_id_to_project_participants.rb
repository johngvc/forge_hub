class AddColumnJoinRequestIdToProjectParticipants < ActiveRecord::Migration[6.0]
  def change
    add_reference :participants, :join_requests, foreign_key: true
  end
end
