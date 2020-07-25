class CalendarsController < ApplicationController
    before_action :logged_in_user
    before_action :correct_calendar_user

    def new
        @calendar = Post.find(params[:post_id]).calendars.new
        last_month = Post.find(params[:post_id]).calendars.order(id: "DESC").first.month
        @calendar.month = last_month.next_month
    end

    def create
        @post = Post.find(params[:post_id])
        @calendar = @post.calendars.build(calendar_params)
        respond_to do |format|
            if @calendar.save
                @post.updateCalendars
                flash[:success] = 'カレンダーの成功しました'
                format.html { redirect_to @post }
                format.js { @status = "success"}
            else
                format.html { redirect_to @post }
                format.js { @status = "fail"}
            end
        end
    end

    def edit
        @calendar = Calendar.find_by(id: params[:id])
    end

    def update
        @calendar = Calendar.find(params[:id])
        respond_to do |format|
            if @calendar.update(calendar_params)
                @post = Post.find(@calendar.post_id)
                @post.updateCalendars
                @calendars = @post.calendars
                format.html { redirect_to @post }
                format.js { @status = "success"}
            else
                format.html
                format.js { @status = "fail" }
            end
        end
    end

    private
    def calendar_params
        params.require(:calendar).permit(:month, :content, :temperature, :harvested_flag, :picture)
    end

    def correct_calendar_user
        if params[:id]
            @user = Calendar.find(params[:id]).post.user
        else
            @user = Post.find(params[:post_id]).user
        end
        redirect_to(root_url) unless @user == current_user
    end
end
