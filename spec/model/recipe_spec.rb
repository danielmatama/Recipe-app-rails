require 'rails_helper'

RSpec.describe Recipe, type: :model do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'Daniel', email: 'Daniel@gmail.com', password: '123456')
    sign_in @user
  end
  describe 'Validations' do
    it 'is valid with valid attributes' do
      user = User.create(name: 'Daniel', email: 'Daniel@gmail.com', password: '123456')
      recipe = Recipe.new(
        name: 'Chocolate Cake',
        preparation_time: 30,
        cooking_time: 45,
        description: 'A delicious chocolate cake recipe',
        user:
      )
      expect(recipe).to be_valid
    end

    it 'requires name to be present' do
      recipe = Recipe.new(
        name: '',
        preparation_time: 30,
        cooking_time: 45,
        description: 'A delicious chocolate cake recipe'
      )
      expect(recipe).to_not be_valid
    end

    it 'requires preparation_time to be present' do
      recipe = Recipe.new(
        name: 'Chocolate Cake',
        preparation_time: nil,
        cooking_time: 45,
        description: 'A delicious chocolate cake recipe'
      )
      expect(recipe).to_not be_valid
    end

    it 'requires cooking_time to be present' do
      recipe = Recipe.new(
        name: 'Chocolate Cake',
        preparation_time: 30,
        cooking_time: nil,
        description: 'A delicious chocolate cake recipe'
      )
      expect(recipe).to_not be_valid
    end

    it 'requires description to be present' do
      recipe = Recipe.new(
        name: 'Chocolate Cake',
        preparation_time: 30,
        cooking_time: 45,
        description: ''
      )
      expect(recipe).to_not be_valid
    end

    it 'requires preparation_time to be numeric' do
      recipe = Recipe.new(
        name: 'Chocolate Cake',
        preparation_time: 'invalid',
        cooking_time: 45,
        description: 'A delicious chocolate cake recipe'
      )
      expect(recipe).to_not be_valid
    end

    it 'requires cooking_time to be numeric' do
      recipe = Recipe.new(
        name: 'Chocolate Cake',
        preparation_time: 30,
        cooking_time: 'invalid',
        description: 'A delicious chocolate cake recipe'
      )
      expect(recipe).to_not be_valid
    end

    it 'requires preparation_time to be greater than or equal to zero' do
      recipe = Recipe.new(
        name: 'Chocolate Cake',
        preparation_time: -1,
        cooking_time: 45,
        description: 'A delicious chocolate cake recipe'
      )
      expect(recipe).to_not be_valid
    end

    it 'requires cooking_time to be greater than or equal to zero' do
      recipe = Recipe.new(
        name: 'Chocolate Cake',
        preparation_time: 30,
        cooking_time: -1,
        description: 'A delicious chocolate cake recipe'
      )
      expect(recipe).to_not be_valid
    end
  end
end
