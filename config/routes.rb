Rails.application.routes.draw do
  resources :lists do
    collection { post :import }
  end
  root to: 'lists#index'
end
