class CreateBootcamps < ActiveRecord::Migration[6.0]
  def change
    create_table :bootcamps do |t|
      t.string :name
      t.string :country
      t.string :city
      t.string :website

      t.timestamps
    end
  end
end
