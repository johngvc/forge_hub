class ChangeParticipantIdToInvitingParticipantId < ActiveRecord::Migration[6.0]
  def change
    rename_column :participants, :participant_id, :invite_participant_id
  end
end
