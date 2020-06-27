class Post < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  has_many :calendars, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :passive_likes, class_name: "Like", foreign_key: "post_id", dependent: :destroy
  has_many :liked, through: :passive_likes, source: :user
  validates :title, presence: true, length: { maximum: 60 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :picture, presence: { message: 'を選択してください。' }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :prefecture_id, presence: { message: 'を選択してください。' }
  validates :planted_at, presence: { message: 'を選択してください。' }
end
