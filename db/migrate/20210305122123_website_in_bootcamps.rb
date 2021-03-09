class RenameWbesiteToWebsiteInBootcamps < ActiveRecord::Migration[6.0]
  def change
    rename_column :bootcamps, :wbesite, :website
  end
end
