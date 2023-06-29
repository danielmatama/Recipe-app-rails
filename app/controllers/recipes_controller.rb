class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = current_user.recipes
  end

  def show
    recipe_test = Recipe.find(params[:id])
    unless recipe_test.user == current_user || recipe_test.public?
      flash[:alert] = 'You do not have access to see details.'
      return redirect_to recipes_path
    end

    @recipe = Recipe.find(params[:id])
    @recipe_foods = RecipeFood.where(recipe_id: @recipe.id).includes(:food, :recipe)
    
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
  def public_recipes
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
