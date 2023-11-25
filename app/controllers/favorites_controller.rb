class FavoritesController < ApplicationController
  def create
    # テーブルからbook_idを探して、そのidをbooksテーブルから探す。
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
      # format.html { redirect_to request.referer }
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
  end
  
end
