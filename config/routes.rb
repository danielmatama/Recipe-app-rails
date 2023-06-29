Rails.application.routes.draw do
  resources :foods, only: [:index, :new, :create, :show, :destroy]

  resources :recipes, only: [:index, :new, :create, :show, :destroy] do
    resources :recipe_foods, only: [:new, :create, :destroy]
    resources :shopping_lists, only: [:index]
  end

  get 'public_recipes', to: 'recipes#public_recipes'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :recipes, only: [:index, :show, :create, :edit, :destroy]
  end
end

