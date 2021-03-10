class AddLastLoginToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_login, :datetime
    add_column :users, :current_login, :datetime
  end
end
