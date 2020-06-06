class AddIndexToPlantsName < ActiveRecord::Migration[5.2]
  def change
    add_index :plants, :name, unique: true
  end
end
