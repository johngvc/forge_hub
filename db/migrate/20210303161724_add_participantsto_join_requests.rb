class AddParticipantstoJoinRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :join_requests, :participants, foreign_key: true, default: nil
  end
end
