class Recipe < ApplicationRecord
  belongs_to :user

  def all_recipe
    recipes.order(created_at: :desc)
  end
end
