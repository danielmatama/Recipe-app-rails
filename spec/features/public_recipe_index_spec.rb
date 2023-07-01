require 'rails_helper'

RSpec.describe 'Recipe index', type: :feature do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'Ameerah', email: 'Ameerah@mail.com', password: 'Ameerah@2020')
    sign_in @user
    @recipe = Recipe.create(user: @user, name: 'Banga', preparation_time: 2, cooking_time: 5,
                            description: ' Soup', public: true)
    visit public_recipes_path(@user)
  end

  it 'should display the name of the recipe' do
    expect(page).to have_content(@recipe.name)
  end

  it 'Displays the heading' do
    expect(page).to have_content('Public Recipes')
  end

  it 'Displays the Total Products' do
    expect(page).to have_content('Total')
  end

  it 'Displays the navbar content' do
    expect(page).to have_content('Recipe')
  end
end
