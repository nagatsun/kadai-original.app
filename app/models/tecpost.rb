class Tecpost < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 15 }
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites,dependent: :destroy
  has_many :users, through: :favorites
  
  has_many :comments,dependent: :destroy
  has_many :users, through: :comments
  
  def remsg(tecpost)
      comments.find_or_create_by(tecpost_id: tecpost.id)
  end
  
  def unremsg(tecpost)
    comment = self.comments.find_by(tecpost_id: tecpost.id)
    comment.destroy if comment
  end

  def remsging?(tecpost)
    self.remsgs.include?(tecpost)
  end
end