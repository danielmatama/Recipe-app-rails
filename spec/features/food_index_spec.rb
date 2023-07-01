require 'rails_helper'

RSpec.describe 'Food', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'index' do
    before(:each) do
      @user = User.create(name: 'Ameerah', email: 'Ameerah@mail.com', password: 'Ameerah@2020')
      sign_in @user
      @food = Food.create(user: @user, name: 'Banana', measurement_unit: 'kg', quantity: 5, price: 10)
      visit user_foods_path(@user)
    end
    it 'renders name of food' do
      expect(page).to have_content(@food.name)
    end

    it 'renders the  measurement unit of the page' do
      expect(page).to have_content(@food.measurement_unit)
    end

    it 'renders he price of the food' do
      expect(page).to have_content(@food.price)
    end

    it 'should render a button add food ' do
      expect(page).to have_content('Add Food')
    end

    it 'redirects to a form for new food' do
      click_link 'Add Food'
      expect(page).to have_current_path(new_user_food_path(@user))
    end
  end
end
