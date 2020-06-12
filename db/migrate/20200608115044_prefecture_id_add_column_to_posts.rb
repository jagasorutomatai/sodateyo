class PrefectureIdAddColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :prefectures, foreign_key: true
  end
end
