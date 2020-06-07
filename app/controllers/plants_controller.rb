class PlantsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @plants = Plant.all.page(params[:page])
  end

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

  def edit
    @plant = Plant.find_by(id: params[:id])
  end

  def update
    @plant = Plant.find(params[:id])
    if @plant.update(plant_params)
      flash[:success] = '植物の情報を変更しました'
      redirect_to @plant
    else
      render 'edit'
    end
  end

  def destroy
    Plant.find(params[:id]).destroy
    flash[:success] = '植物の情報を削除しました'
    redirect_to plants_url
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :description, :picture, :calendar_id)
  end
end
