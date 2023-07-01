require 'rails_helper'
RSpec.describe 'Recipes', type: :request do
  include Devise::Test::IntegrationHelpers
  let!(:user) { User.create(name: 'Tom', email: 'shafiu@gamil.com', password: '123456') }

  before do
    sign_in user
  end

  let!(:valid_attributes) do
    { name: 'recipe 1', preparation_time: 40, cooking_time: 140,
      description: 'it is the most amazing recipe on the planet', public: true, user: }
  end

  let!(:invalid_attributes) do
    { name: '', preparation_time: nil, cooking_time: nil,
      description: 'it is the most amazing recipe on the planet', public: true, user: }
  end

  describe 'GET /index' do
    it 'returns a successful response' do
      get user_recipes_path(user)
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get user_recipes_path(user)
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET /show' do
    it 'renders a successful response' do
      recipe = Recipe.create! valid_attributes
      get user_recipe_path(user, recipe)
      expect(response).to be_successful
    end

    it 'renders a correct template' do
      recipe = Recipe.create! valid_attributes
      get user_recipe_path(user, recipe)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_user_recipe_url(user)
      expect(response).to be_successful
    end

    it 'renders a correct template' do
      get new_user_recipe_url(user)
      expect(response).to render_template('new')
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'creates a new recipe' do
        expect do
          post user_recipes_path(user), params: { recipe: valid_attributes }
        end.to change(Recipe, :count).by(1)
        expect(flash[:notice]).to eq('Recipe created successfully!')
      end
    end
    context 'with invalid attributes' do
      it 'creates a new recipe' do
        post user_recipes_path(user), params: { recipe: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'delete a recipe' do
      recipe = Recipe.create! valid_attributes
      expect do
        delete user_recipe_url(user, recipe)
      end.to change(Recipe, :count).by(-1)
      expect(flash[:notice]).to eq('Recipe deleted successfully!')
    end
  end
end
