class AddStatusToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :status, :string
  end
end
