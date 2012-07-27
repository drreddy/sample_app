class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
	
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
	@microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
	  sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @usersearch = @user.followed_users
	@users = @usersearch.search(params[:search]).paginate(:page => params[:page])
    @path = following_user_path(current_user)
	render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @usersearch = @user.followers
	@users = @usersearch.search(params[:search]).paginate(:page => params[:page])
	@path = followers_user_path(current_user)
    render 'show_follow'
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  def index
    @users = User.search(params[:search]).paginate(:page => params[:page])
  end
  
  def edit
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

    def signed_in_user
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end
	
	def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
