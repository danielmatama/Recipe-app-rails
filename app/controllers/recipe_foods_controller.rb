class RecipeFoodsController < ApplicationController
  def new
    @user = current_user
    @foods = Food.all
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def create
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)
    @foods = Food.all
    if @recipe_food.save
      redirect_to user_recipes_url, notice: 'Recipe was added successfully!'
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @food = Food.find(@recipe_food.food_id)
    @foods = Food.all
  end

  def update
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @food = Food.find(@recipe_food.food_id)
    @food.update
    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe_food.recipe), notice: 'Recipe Food updated successfully!'
    else
      puts @recipe.errors.full_messages
      render :edit
    end
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end

  def destroy
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    if @recipe_food.destroy.destroy
      redirect_to user_recipe_path, notice: 'Recipe deleted successfully!'
    else
      flash[:notice] = 'Something went wrong, Try again!'
      render :new
    end
  end
end
