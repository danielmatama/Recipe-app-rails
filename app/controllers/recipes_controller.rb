class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to users_path, notice: 'Recipe created successfully!'
    else
      puts @recipe.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      redirect_to users_path, notice: 'Recipe created successfully!'
    else
      puts @recipe.errors.full_messages
      render :new
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
