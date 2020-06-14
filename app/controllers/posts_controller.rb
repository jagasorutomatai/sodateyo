class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def index
    @search = Post.joins(:prefecture, :user, :calendars).includes(:prefecture, :user, :calendars).ransack(params[:q])
    @posts = @search.result
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
    @user = User.find(@post.user_id)
    @prefecture = Prefecture.find(@post.prefecture_id)
    @calendars = Calendar.where(post_id: @post.id)
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
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
end
