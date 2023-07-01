class Food < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods
  validates :name, :measurement_unit, :price, :quantity, presence: true
  validates :price, :quantity, numericality: { greater_than: 0 }
  belongs_to :user unless method_defined?(:user)
end
