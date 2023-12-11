class Group < ApplicationRecord
  
  has_many :user_groups
  has_many :users, through: :user_groups
  
  validates :name, presence: true, length: {minimum: 2, maximum: 30}
  validates :introduction, presence: true, length: {maximum: 50}
  has_one_attached :image
  
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end 
  
end
