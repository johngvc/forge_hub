class AddCategoryToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :category, :string
  end
end
