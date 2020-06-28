class LikesController < ApplicationController
    before_action :logged_in_user
    
    def create
        @post = Post.find(params[:post_id])
        current_user.like(@post)
        @likes = @post.liked
        respond_to do |format|
            format.html { redirect_to @post }
            format.js
        end
    end

    def destroy
        puts params
        @post = Like.find(params[:id]).post
        current_user.unlike(@post)
        @likes = @post.liked
        respond_to do |format|
            format.html { redirect_to @post }
            format.js
        end
    end
end
