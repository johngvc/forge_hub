class CreateChatroomParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :chatroom_participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chatroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
