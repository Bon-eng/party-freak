Rails.application.routes.draw do
  
  devise_for :users
  root to: 'parties#index'
  resources :parties, only: [:new, :create, :index, :show, :edit, :update]
  
end
