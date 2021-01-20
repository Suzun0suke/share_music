Rails.application.routes.draw do
  devise_for :users
  root to:"posts#index"
  resources :posts, only:[:new, :create, :show] do
    collection do
      get 'search'
    end
  end
end
