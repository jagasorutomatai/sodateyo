class CalendarsController < ApplicationController
    before_action :logged_in_user
    before_action :correct_calendar_user

    def edit
        @calendar = Calendar.find_by(id: params[:id])
    end

    def update
        @calendar = Calendar.find(params[:id])
        respond_to do |format|
            if @calendar.update(calendar_params)
                @post = Post.find(@calendar.post_id)
                format.html { redirect_to @post }
                format.js { @status = "success"}
            else
                format.html { render 'edit' }
                format.js { @status = "fail"}
            end
        end
    end

    private
    def calendar_params
        params.require(:calendar).permit(:content, :temperature, :harvested_flag, :picture)
    end

    def correct_calendar_user
        @user = Calendar.find(params[:id]).post.user
        redirect_to(root_url) unless @user == current_user
    end
end
