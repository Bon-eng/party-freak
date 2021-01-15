Rails.application.routes.draw do
  
  namespace :admin do
    resources :parties do
    end
  end

  devise_for :users
  root to: 'parties#index'
  resources :parties do
    resources :reviews, only: [:index, :create, :show]
  end

  resources :users, only: :show

end
