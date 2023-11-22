class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    # current_userと紐づけて能動的関係を作成/登録する
    current_user.follow(user)
    
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end
  
  def following
    user = User.find(params[:id])
    @following = user.following
  end 
  
  def followers
    user = User.find(params[:id])
    @followers = user.followers
  end 
  
end
