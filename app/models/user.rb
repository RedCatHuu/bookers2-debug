class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  # フォロワー目線。フォローしているユーザーとの関連付け。follower_idを取得。
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローしているユーザーを取得。上記で取得したfollower_idと繋がるfollowed_idを取得。:sourceパラーメーターを使ってfolloweing配列のもとは「followed」idの集合であるということをrailsに伝えている。
  # この記述があることで、User.following.countのように、フォローしてくれた人を数えることができる。
  has_many :following, through: :active_relationships, source: :followed
  
  # followed目線。フォロワーとの関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # followersで探せるからsourceいらない
  has_many :followers, through: :passive_relationships
  
  has_many :read_counts, dependent: :destroy
  
  validates :name, length: {minimum: 2, maximum: 20}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end 
  
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end 
  
  def following?(user)
    following.include?(user)
  end 
  
  GUEST_USER_EMAIL = "guest@example.com"
    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "guestuser"
      end 
    end 
    
    def guest_user?
      email == GUEST_USER_EMAIL
    end
    
end
