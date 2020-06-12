class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.date :month
      t.text :content
      t.integer :temperature, limit: 1
      t.date :planted_at
      t.date :harvested_at
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
