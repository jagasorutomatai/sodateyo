class CommentsController < ApplicationController
    before_action :logged_in_user

    def create
        @comment = current_user.comments.build(comment_params)
        @post = Post.find(params[:post_id])
        @comment.post_id = @post.id
        respond_to do |format|
            if @comment.save
                format.html { redirect_to @post }
                format.js { @status = "success"}
            else
                format.html { redirect_to @post }
                format.js { @status = "fail"}
            end
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
