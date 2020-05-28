class Tecpost < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 15 }
  validates :content, presence: true, length: { maximum: 255 }
end
