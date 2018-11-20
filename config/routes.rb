Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :teams
  resources :players
  resources :games
  resources :scores, only: [:create, :destroy]
end
