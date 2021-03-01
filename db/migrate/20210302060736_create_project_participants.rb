class CreateProjectParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :project_participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project_participant, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.boolean :is_founder
      t.date :invited_on
      t.date :accepted_on
      t.string :clearence_level

      t.timestamps
    end
  end
end
