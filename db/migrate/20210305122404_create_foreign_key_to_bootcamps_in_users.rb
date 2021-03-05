class CreateForeignKeyToBootcampsInUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :foreign_key_to_bootcamps_in_users do |t|
      add_reference :users, :bootcamps, foreign_key: true
    end
  end
end
