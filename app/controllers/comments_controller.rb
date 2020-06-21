class CommentsController < ApplicationController
    def create
        @comment = current_user.comments.build(comment_params)
        @post = Post.find(params[:post_id])
        @comment.post_id = @post.id
        respond_to do |format|
            if @comment.save
                format.html { redirect_to @post }
                format.js
            else
                format.html { redirect_to @post }
            end
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
