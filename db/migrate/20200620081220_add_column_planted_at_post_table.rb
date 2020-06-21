class AddColumnPlantedAtPostTable < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :planted_at, :date
  end
end
