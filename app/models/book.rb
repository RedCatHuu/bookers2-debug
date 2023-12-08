class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites,dependent: :destroy
  
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags
  
  has_many :read_counts, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end 
  
  def save_book_tags(category)
    # 投稿物にタグが存在していれば、タグの名前を配列として取得。update用
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在のタグから、新規タグを引き、不要なタグを特定。
    old_tags = current_tags - category
    # 新規タグから現在のタグを引き、新規追加分を特定
    new_tags = category - current_tags
    
    old_tags.each do |old_name|
      # Tag.find_by(name:old_name)の返り値をdeleteの引数に渡し、中間テーブルのレコードを削除。
      # 引数のobjectをbook.tagsから消去。
      # 引数なしのdeleteだと反応しない。
      # self.tags.delete(name:old_name)だと、引数がTagオブジェクトではなくハッシュであるためにエラーが起こる。
      self.tags.delete(Tag.find_by(name:old_name))
    end 
    
    new_tags.each do |new_name|
      # Tag.createにすると同じtagがあっても無視して追加してしまう。tagが重複する。
      tag = Tag.find_or_create_by(name:new_name)
      # self.tags.push(tag)と同じ意味
      self.tags << tag
    end 
  end 
  
  # scope :sort_new, -> { order(created_at: :desc)}
  # カラムをidにしても同じ。
  scope :sort_new, -> { order(id: :desc)}
  # 以下はscope :sort_new, -> { order(created_at: :asc)}と同じ意味デフォルトがascだから記述はいらない。
  scope :sort_old, -> { order(:created_at)}
  
end
