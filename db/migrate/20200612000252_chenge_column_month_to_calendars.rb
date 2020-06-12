class ChengeColumnMonthToCalendars < ActiveRecord::Migration[5.2]
  def change
    remove_column :calendars, :month, :date
    add_column :calendars, :month, :integer, limit: 1
  end
end
