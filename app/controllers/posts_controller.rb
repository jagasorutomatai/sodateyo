
class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_post_user, only: [:edit, :update]

  def index
    @search = Post.ransack(params[:q])
    @posts = @search.result.page(params[:page]).per(5)
  end

  def new
    @post = current_user.posts.build if logged_in?
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      # 1-12月のカレンダーのデータを作成
      planted_at = Date.parse(params[:post][:planted_at])
      12.times do |count|
        if count==0
          @post.calendars.create(month: planted_at, planted_flag: true)
        else
          @post.calendars.create(month: planted_at)
        end
        planted_at = planted_at.next_month
      end
      flash[:success] = '記事の登録に成功しました'
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @prefecture = Prefecture.find(@post.prefecture_id)
    @calendars = Calendar.where(post_id: @post.id)
    @likes = @post.liked
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = '記事の情報を変更しました'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = '投稿を削除しました'
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :picture, :prefecture_id, :planted_at)
  end

  def correct_post_user
    @user = Post.find(params[:id]).user
    redirect_to(root_url) unless @user == current_user
  end
end
