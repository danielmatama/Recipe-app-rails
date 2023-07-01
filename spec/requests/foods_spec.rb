require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'Tom', email: 'shafiu@gamil.com', password: '123456')
    sign_in @user
  end
  describe 'GET /index' do
    it 'returns a successful response' do
      get root_path
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'returns a successful response' do
      get user_foods_path(@user)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'creates a new food' do
        expect do
          post user_foods_path(user_id: @user.id),
               params: { food: { name: 'new_food', measurement_unit: 'grams', price: 2.5, quantity: 4, user: @user } }
        end.to change(Food, :count).by(1)
        expect(response).to redirect_to(user_foods_path)
        follow_redirect!
        expect(response).to be_successful
      end
    end
  end
end
