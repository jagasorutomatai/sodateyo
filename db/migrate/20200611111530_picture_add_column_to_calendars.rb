class PictureAddColumnToCalendars < ActiveRecord::Migration[5.2]
  def change
    add_column :calendars, :picture, :string
  end
end
