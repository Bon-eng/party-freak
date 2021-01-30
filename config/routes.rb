Rails.application.routes.draw do

  devise_for :users
  root to: 'parties#index'
  resources :parties do
    resources :reviews, only: [:index, :create, :show, :edit, :update, :destroy]
  end

  resources :users, only: :show

end
