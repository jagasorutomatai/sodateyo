class Calendar < ApplicationRecord
  belongs_to :post
  validates :month, presence: true
  validates :content, length: { maximum: 140 }
  mount_uploader :picture, PictureUploader
  validate :picture_size

  private

  def picture_size
    erros.add(:picture, '画像のサイズが大きなすぎます(上限5MB)') if picture.size > 5.megabytes
  end
end
