class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :name
      t.text :description
      t.string :picture
      t.integer :calendar_id

      t.timestamps
    end
  end
end
