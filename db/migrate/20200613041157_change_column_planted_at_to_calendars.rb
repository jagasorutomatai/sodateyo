class ChangeColumnPlantedAtToCalendars < ActiveRecord::Migration[5.2]
  def change
    remove_column :calendars, :planted_at, :date
    remove_column :calendars, :harvested_at, :date
    add_column :calendars, :planted_flag, :boolean
    add_column :calendars, :harvested_flag, :boolean
  end
end
