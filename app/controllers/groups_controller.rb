class GroupsController < ApplicationController
  
  def new
    @group = Group.new
  end 
  
  def index
    @groups = Group.all
  end 
  
  def show
    @group = Group.find(params[:id])
  end 
  
  def create
    group = Group.new(group_params)
    group.owner_id = current_user.id
    group.users << current_user
    # 上は以下のコードと同じか？AIは同じ目的を果たしているとは言っている。
    # current_user.groups_users.new(group_id: group.id)
    if group.save
      flash[:notice] = "You have created group successfully."
      redirect_to group_path(group)
    else
      @group = Group.new
      render :new
    end 
    
  end 
  
  def edit
    @group = Group.find(params[:id])
  end 
  
  def join
    @group = Group.find(params[:id])
    @group.users << current_user
    redirect_to group_path(@group)
  end 
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end 
  
end
