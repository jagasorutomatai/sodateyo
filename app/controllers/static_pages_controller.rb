class StaticPagesController < ApplicationController
  def home
    # 最近更新があった記事を抽出
    @updated_ranking = Post.all.order(updated_at: "DESC").limit(3)

    # いいねの多い記事
    ranking = Post.joins(:liked).group(:id).order("count_all DESC").limit(3).count.keys
    @like_ranking = []
    ranking.each do |id|
        @like_ranking.push(Post.find(id))
    end
  end
end
