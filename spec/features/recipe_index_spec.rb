require 'rails_helper'

RSpec.describe 'Recipes', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'index' do
    before(:each) do
      @user = User.create(name: 'Ameerah', email: 'Ameerah@mail.com', password: 'Ameerah@2020')
      sign_in @user
      @recipe = Recipe.create(user: @user, name: 'Banga', preparation_time: 3, cooking_time: 1,
                              description: 'Soup', public: true)
      visit user_recipes_path(@user)
    end

    it 'renders name of recipe' do
      expect(page).to have_content(@recipe.name)
    end

    it 'renders description of the recipe' do
      expect(page).to have_content(@recipe.description)
    end

    it 'renders remove button' do
      expect(page).to have_content('Remove')
    end

    it 'redirects to delete path' do
      Recipe.create(name: 'Chocolate Cake', user: @user)
      visit user_recipes_path(@user)
      click_link 'Remove'

      expect(page).to have_current_path(user_recipes_path(@user))
    end

    it 'renders a button to add recipe' do
      expect(page).to have_content('New Recipe')
    end

    it 'redirects to a form for new recipe' do
      click_link 'New Recipe'
      expect(page).to have_current_path(new_user_recipe_path(@user))
    end
  end
end
