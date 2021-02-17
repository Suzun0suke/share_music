Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to:"posts#index"
  resources :posts do
    resources :likes, only:[:create, :destroy]
    collection do
      get 'search', 'ranking'
    end
  end
  resources :users, only:[:show]
end
