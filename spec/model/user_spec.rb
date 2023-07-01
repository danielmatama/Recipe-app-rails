require 'rails_helper'

RSpec.describe User, type: :model do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'Daniel', email: 'Daniel@gmail.com', password: '123456')
    sign_in @user
  end
  describe 'Validations' do
    it 'name should be present' do
      @user.name = ''
      expect(@user).to_not be_valid
    end
    it 'should be valid if name is present' do
      @user.name
      expect(@user).to be_valid
    end
  end
end
