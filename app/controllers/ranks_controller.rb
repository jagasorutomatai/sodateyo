class RanksController < ApplicationController
    def index
        #いいねの多い投稿を取得
        ranking = Post.joins(:liked).group(:id).order("count_all DESC").limit(5).count.keys
        @likes_ranking = []
        ranking.each do |id|
            @likes_ranking.push(Post.find(id))
        end

        #コメントが多い投稿を取得
        ranking = Post.joins(:comments).group(:id).order("count_all DESC").limit(5).count.keys
        @comments_ranking = []
        ranking.each do |id|
            @comments_ranking.push(Post.find(id))
        end
    end
end
