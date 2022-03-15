class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :relationships,class_name:"Relationship",foreign_key:"follwer_id",dependent: :destroy
  has_many :reverse_of_relationships,class_name:"Relationship",foreign_key:"follwed_id",dependent: :destroy

  has_many :followers, through: :relationship,source: :follower
  has_many :followeds, through: :reverse_of_relationships,source: :followed
  
  has_one_attached :profile_image
  
  validates :name, uniqueness: true,presence: true,length: { minimum: 2, maximum: 20 }
  validates :introduction,length: { maximum: 50 }

  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
