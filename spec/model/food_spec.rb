require 'rails_helper'

RSpec.describe Food, type: :model do
  include Devise::Test::IntegrationHelpers

  before :each do
    @user = User.create(name: 'Daniel', email: 'Daniel@gmail.com', password: '123456')
    sign_in @user
  end

  describe 'Validations' do
    let(:valid_attributes) do
      {
        name: 'Pie',
        measurement_unit: 'unit',
        price: 4,
        quantity: 2,
        user: @user
      }
    end

    it 'is valid with valid attributes' do
      food = Food.new(valid_attributes)
      expect(food).to be_valid
    end

    it 'requires name to be present' do
      food = Food.new(valid_attributes.merge(name: ''))
      expect(food).to_not be_valid
    end

    it 'requires measurement_unit to be present' do
      food = Food.new(valid_attributes.merge(measurement_unit: nil))
      expect(food).to_not be_valid
    end

    it 'requires price to be present' do
      food = Food.new(valid_attributes.merge(price: nil))
      expect(food).to_not be_valid
    end

    it 'requires quantity to be present' do
      food = Food.new(valid_attributes.merge(quantity: nil))
      expect(food).to_not be_valid
    end

    it 'requires price to be numeric' do
      food = Food.new(valid_attributes.merge(price: 'invalid'))
      expect(food).to_not be_valid
    end

    it 'requires quantity to be numeric' do
      food = Food.new(valid_attributes.merge(quantity: 'invalid'))
      expect(food).to_not be_valid
    end

    it 'requires price to be greater than or equal to zero' do
      food = Food.new(valid_attributes.merge(price: -1))
      expect(food).to_not be_valid
    end

    it 'requires quantity to be greater than or equal to zero' do
      food = Food.new(valid_attributes.merge(quantity: -2))
      expect(food).to_not be_valid
    end
  end
end
