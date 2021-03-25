class CreateScrapeLinkedins < ActiveRecord::Migration[6.0]
  def change
    create_table :scrape_linkedins do |t|

      t.timestamps
    end
  end
end
