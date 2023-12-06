class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites,dependent: :destroy
  
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags
  
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end 
  
  def save_book_tags(category)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - category
    new_tags = category - current_tags
    
    old_tags.each do |old_name|
      self.tags.delte Tag.find_by(name:old_name)
    end 
    
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end 
  end 
  
end
