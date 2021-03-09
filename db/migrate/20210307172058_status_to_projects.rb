class StatusToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :is_suspended, :boolean, default: false
  end
end
