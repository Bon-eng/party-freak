Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  root to: 'parties#index'
  resources :parties do
    resources :reviews, only: [:create, :edit, :update, :destroy]
    collection do
      get 'lineup'
      get 'search'
    end
  end

  resources :users, only: [:show, :edit, :update]

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

end
