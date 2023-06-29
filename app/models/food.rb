class Food < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods

  validates :name, :measurement_unit, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  belongs_to :user unless method_defined?(:user)
end
