class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    # @user = @book.user
    # @book_new = Book.new
    @comment = BookComment.new
    # @tag = @book.tags
  end

  def index
    @book = Book.new
    @books = Book.all
    @tag_list = Tag.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 変数bookのnameキーを取得し、splitで配列に変換。
    tag_list = params[:book][:name].split(' ')
    if @book.save
      @book.save_book_tags(tag_list)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    tag_list = params[:book][:name].split(" ")
    if @book.update(book_params)
      @book.save_book_tags(tag_list)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end
  
  def destroy
    book_show = Book.find(params[:id])
    book_show.destroy
    redirect_to books_path
  end 
    

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end 
  end
  
end
