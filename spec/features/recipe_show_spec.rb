require 'rails_helper'

RSpec.describe 'Recipes', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'show' do
    before(:each) do
      @user = User.create(name: 'Ameerah', email: 'Ameerah@mail.com', password: 'Ameerah@2020')
      sign_in @user
      @recipe = Recipe.create(user: @user, name: 'Banga', preparation_time: 3, cooking_time: 1,
                              description: 'Soup', public: true)
      visit user_recipe_path(@user, @recipe.id)
    end

    it 'renders name of recipe' do
      expect(page).to have_content(@recipe.name)
    end

    it 'renders preparation time' do
      expect(page).to have_content(@recipe.preparation_time)
    end

    it 'renders cooking time' do
      expect(page).to have_content(@recipe.cooking_time)
    end

    it 'renders add ingredient button' do
      expect(page).to have_content('Add Ingredient')
    end

    it 'renders shopping list button' do
      expect(page).to have_content('Generate Shopping List')
    end
  end
end
