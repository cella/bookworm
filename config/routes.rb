Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :users do
    resources :shelves
    resources :shelved_books, only: [:create, :destroy]
  end

  resources :books
end
