class Plant < ApplicationRecord
  validates :name, presence: true, length: { maximum: 60 }, uniqueness: true
  validates :description, presence: true, length: { maximum: 254 }
  validates :picture, presence: { message: 'を選択してください。' }
  mount_uploader :picture, PictureUploader
  validate :picture_size

  private

  def picture_size
    erros.add(:picture, '画像のサイズが大きなすぎます(上限5MB)') if picture.size > 5.megabytes
  end
end
