class FoodsController < ApplicationController
  def index
    @user = current_user
    @food = Food.includes(:user).where(user_id: current_user.id)
  end

  def new
    @user = current_user
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to user_foods_path, notice: 'Food was successfully created.' }
      else
        format.html { render :new, alert: 'Food could not be created' }
      end
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @recipe_food = @food.recipe_foods.where(food_id: @food.id)
    @recipe_food.each(&:destroy)
    @food.destroy
    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
    end
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
