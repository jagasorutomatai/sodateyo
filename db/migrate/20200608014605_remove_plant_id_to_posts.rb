class RemovePlantIdToPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :plant_id
  end
end
