require 'rails_helper'

RSpec.describe 'RecipeFood', type: :request do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'Tom', email: 'shafiu@gamil.com', password: '123456')
    @recipe = Recipe.create(name: 'Chocolate Cake',
                            preparation_time: 30,
                            cooking_time: 45,
                            description: 'A delicious chocolate cake recipe',
                            user: @user)
    sign_in @user
    @food = Food.create(name: 'Flour', measurement_unit: 'grams', price: 2, quantity: 500, user: @user)
  end
  describe 'POST /create' do
    it 'creates a new recipe_food' do
      # ...
      before_count = RecipeFood.count

      post user_recipe_recipe_foods_path(user_id: @user.id, recipe_id: @recipe.id),
           params: { recipe_food: { food_id: @food.id, quantity: 3, recipe_id: @recipe.id } }

      after_count = RecipeFood.count
      puts "RecipeFood count before: #{before_count}, after: #{after_count}"

      expect(after_count - before_count).to eq(1)
    end
  end
end
