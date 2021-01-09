Rails.application.routes.draw do
  devise_for :users
  #resources :parties, only: :index
  root to: 'parties#index'
  #get 'parties', to: 'parties#index'
end
