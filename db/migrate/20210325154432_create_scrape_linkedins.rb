class CreateScrapeLinkedins < ActiveRecord::Migration[6.0]
  def change
    create_table :scrape_linkedins do |t|
      t.string :url, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
