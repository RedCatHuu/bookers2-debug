class Tag < ApplicationRecord
  
  # 中間テーブルと連携
  has_many :book_tags
  # 中間テーブルを通してbookテーブルと連携
  has_many :books, through: :book_tags
  
  validates :name, presence:true, length:{maximum:20}
  
end
