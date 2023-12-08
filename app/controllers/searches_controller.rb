class SearchesController < ApplicationController
  def search
    search_word = params[:word]
    @model = params[:model]
    how = params[:how]
    if @model == "User"
      case how.to_i
      when 1 then
        @searches = User.where("name = ?", "#{search_word}")
      when 2 then
        @searches = User.where("name LIKE ?", "%#{search_word}")
      when 3 then
        @searches = User.where("name LIKE ?", "#{search_word}%")
      when 4 then
        @searches = User.where("name LIKE ?", "%#{search_word}%")
      end

    else
      case how.to_i
      when 1 then
        @searches = Book.where("title LIKE ? or body LIKE ?", "#{search_word}", "#{search_word}")
      when 2 then
        @searches = Book.where("title LIKE ? or body LIKE ?", "%#{search_word}", "%#{search_word}")
      when 3 then
        @searches = Book.where("title LIKE ? or body LIKE ?", "#{search_word}%", "#{search_word}%")
      when 4 then
        @searches = Book.where("title LIKE ? or body LIKE ?", "%#{search_word}%", "%#{search_word}%")
      end
    end
  end

  def search_tag
    @tag = Tag.find(params[:tag_id])
  end

  def show
  end


end
