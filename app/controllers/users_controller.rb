class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.all.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'アカウントの登録が完了しました'
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(3)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザーの情報を変更しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'アカウントを削除しました'
    redirect_to users_url
  end

  def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(5)
    @posts = []
    @users.each do |user|
      user.posts.each do |post|
        if post.updated_at >= "2020-07-19 07:29:01"
          @posts.push(post)
        end
      end
    end
    render 'show_follow'
  end

  def followers
    @title = "フォローワー"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(5)
    @posts = []
    @users.each do |user|
      user.posts.each do |post|
        if post.updated_at >= "2020-07-19 07:29:01"
          @posts.push(post)
        end
      end
    end
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
