class ShoppingListsController < ApplicationController
  skip_load_and_authorize_resource
  def index
    @user = current_user
    @recipes = @user.recipes.includes(recipe_foods: :food)
    @shoppinglist = calculate_cart
    @total_items = @shoppinglist.size
    @total_price = calculate_total_price
  end

  private

  def calculate_cart
    cart_raw = build_cart_raw

    shoppinglist = []
    cart_raw.each_value do |recipe_food|
      general_food = find_general_food(recipe_food[:food].name)
      next unless general_food.nil? || general_food.quantity < recipe_food[:quantity]

      quantity = recipe_food[:quantity] - (general_food&.quantity || 0)
      shoppinglist << {
        food: recipe_food[:food],
        quantity:,
        price: (general_food&.price || 0) * quantity
      }
    end

    shoppinglist
  end

  def build_cart_raw
    cart_raw = {}

    @recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        food = recipe_food.food
        cart_raw[food.id] ||= { food:, quantity: 0 }
        cart_raw[food.id][:quantity] += recipe_food.quantity
      end
    end

    cart_raw
  end

  def calculate_total_price
    @shoppinglist.sum { |item| item[:price] }
  end

  def find_general_food(food_name)
    @user.foods.find_by(name: food_name)
  end
end
