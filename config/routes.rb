Rails.application.routes.draw do
  root "players#index"

  resources :players, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :matches, only: [:index, :new, :create, :edit, :update, :destroy]
end
