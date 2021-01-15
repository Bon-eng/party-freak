Rails.application.routes.draw do
  
  devise_for :users
  root to: 'parties#index'
  resources :parties do
    resources :reviews, only: [:create, :index, :show]
  end

  resources :users, only: :show

end
