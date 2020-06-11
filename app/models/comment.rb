class Comment < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
  validates :tecpost_id, presence: true
  
  belongs_to :user
  belongs_to :tecpost
end
