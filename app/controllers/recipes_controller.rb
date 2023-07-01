class RecipesController < ApplicationController
  # before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @user = current_user
    @recipes = @user.recipes
  end

  def show
    recipe_test = Recipe.find(params[:id])
    unless recipe_test.user == current_user || recipe_test.public?
      flash[:alert] = 'You do not have access to see details.'
      return redirect_to recipes_path
    end
    @user = current_user
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  def new
    @user = current_user
    @recipe = Recipe.new
  end

  def create
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to user_recipes_path, notice: 'Recipe created successfully!'
    else
      puts @recipe.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:id])
    @recipe_food = @recipe.recipe_foods.where(recipe_id: @recipe.id)
    @recipe_food.each(&:destroy)
    if @recipe.destroy
      redirect_to user_recipes_path, notice: 'Recipe deleted successfully!'
    else
      flash[:notice] = 'Something went wrong, Try again!'
      render :new
    end
  end

  def public_recipes
    @user = current_user
    @public_recipes = Recipe.where(public: true).includes([:recipe_foods], [:foods])
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
