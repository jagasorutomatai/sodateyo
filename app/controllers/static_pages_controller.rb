class StaticPagesController < ApplicationController
  def home
    ranking = Post.joins(:liked).group(:id).order("count_all DESC").limit(5).count.keys
    @posts = []
    ranking.each do |id|
        @posts.push(Post.find(id))
    end
  end
end
