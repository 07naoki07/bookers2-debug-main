class Book < ApplicationRecord
  has_one_attached :image
  has_many :favorites,dependent: :destroy
  has_many :comments,dependent: :destroy
  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorite_by?(user)
   favorites.exists?(user_id:user.id)
  end
end
