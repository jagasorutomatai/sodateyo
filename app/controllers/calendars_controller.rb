class CalendarsController < ApplicationController
    def edit
        @calendar = Calendar.find_by(id: params[:id])
    end

    def update
        @calendar = Calendar.find(params[:id])
        if @calendar.update(calendar_params)
            @post = Post.find(@calendar.post_id)
            redirect_to @post
        else
            render 'edit'
        end
    end

    private

    def calendar_params
        params.require(:calendar).permit(:month, :content, :temperature, :planted_at, :harvested_at, :picture)
    end
end
