class FoodsController < ApplicationController
  def index
    @foods = current_user.foods
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def edit
    @food = Food.find(params[:id])
  end

  def create
    @food = current_user.foods.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_path, notice: 'Food was successfully created.' }
      else
        flash[:alert] = 'Food od registration unsuccessful'
      end
    end
  end

  def destroy
    food = Food.find(params[:id])
    respond_to do |format|
      if food.destroy
        format.html { redirect_to foods_path, notice: 'Food was deleted successfully.' }
      else
        format.html { render :new, alert: 'An error has occurred while deleting food, try again' }
      end
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
