Rails.application.routes.draw do

  root 'users#index'
  resources :users, only: [:index] do
  resources :foods, only: [:index, :new, :create, :show, :destroy] do
    resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]
  end
 
  end


  get 'public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }


  resources :users, only: [:index, :show] do
    resources :recipes, only: [:index, :new, :create, :show, :destroy] do
      resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]
      resources :shopping_lists, only: [:index]
    end
  end
end

