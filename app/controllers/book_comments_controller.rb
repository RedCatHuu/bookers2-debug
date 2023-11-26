class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    # 現在のユーザーに関連付けられた新しいコメントを作成
    @comment = current_user.book_comments.new(book_comment_params)
    # 該当のデータのidにコメントのidを代入
    @comment.book_id = @book.id
    @comment.save
    # redirect_to book_path(@book)
  end

  def destroy
    comment = BookComment.find(params[:id])
    @book = comment.book
    comment.destroy
    # BookComment.find(params[:id]).destroy
    # respond_to do |format|
    #   format.html { redirect_to request.referer }
    #   format.js
    # end
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end 
  
end
