require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  include Devise::Test::IntegrationHelpers

  before :each do
    @user = User.create(name: 'Daniel', email: 'Daniel@gmail.com', password: '123456')
    sign_in @user
  end
  describe 'Validations' do
    it 'is valid with valid attributes' do
      food = Food.create(name: 'Pie', measurement_unit: 'unit', price: 4, quantity: 2)
      recipe = Recipe.create(name: 'Apple Pie', preparation_time: 30, cooking_time: 60,
                             description: 'Delicious apple pie recipe')
      recipe_food = RecipeFood.new(food:, recipe:, quantity: 3)
      expect(recipe_food).to be_valid
    end

    it 'requires quantity to be present' do
      recipe_food = RecipeFood.new(quantity: nil)
      expect(recipe_food).to_not be_valid
    end

    it 'requires quantity to be numeric' do
      recipe_food = RecipeFood.new(quantity: 'invalid')
      expect(recipe_food).to_not be_valid
    end

    it 'requires quantity to be greater than or equal to zero' do
      recipe_food = RecipeFood.new(quantity: -1)
      expect(recipe_food).to_not be_valid
    end
  end
end
