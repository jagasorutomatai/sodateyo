class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 60 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :picture, presence: { message: 'を選択してください。' }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
end
