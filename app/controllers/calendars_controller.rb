class CalendarsController < ApplicationController
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
        params.require(:calendar).permit(:month, :content, :temperature, :planted_at, :harvested_at, :picture)
    end
end
