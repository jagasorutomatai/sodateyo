class ChageColumnMonthToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :calendars, :month, :date
  end
end
