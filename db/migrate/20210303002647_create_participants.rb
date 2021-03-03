class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :participant, foreign_key: true
      t.boolean :is_founder, default: false
      t.datetime :invited_at
      t.datetime :accepted_at
    end
  end
end
