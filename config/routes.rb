Rails.application.routes.draw do
  devise_for :users
  root to:"posts#index"
  resources :posts, only:[:new, :create] do
    collection do
      get 'tag_search'
      get 'search'
    end
  end
end
