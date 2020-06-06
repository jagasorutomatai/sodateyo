class PlantsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def show
    @plant = Plant.find(params[:id])
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(plant_params)
    if @plant.save
      flash[:success] = '植物の登録に成功しました'
      redirect_to @plant
    else
      render 'new'
    end
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :description, :picture)
  end
end
