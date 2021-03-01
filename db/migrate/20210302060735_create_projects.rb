class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :linkedin_url
      t.string :github_url
      t.string :trello_url

      t.timestamps
    end
  end
end
