class ChangeColumnDefaultFlagToCalendars < ActiveRecord::Migration[5.2]
  def change
    change_column :calendars, :planted_flag, :boolean, default: false
    change_column :calendars, :harvested_flag, :boolean, default: false
  end
end
