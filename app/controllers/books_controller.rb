class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    # @user = @book.user
    # @book_new = Book.new
    @comment = BookComment.new
    # @tag = @book.tags
    # read_count = ReadCount.new(book_id: @book.id, user_id: current_user.id)
    # read_count.save
    # 上2行をまとめて書くと下記のようになる。unlessは除く。
    # timezoneによって、今日作成した閲覧レコードを抽出、その中で、現在のユーザーが現在の本を読んだ記録があるか探す。
    unless ReadCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user, book_id: @book.id)
      current_user.read_counts.create(book_id: @book.id)
    end 
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
