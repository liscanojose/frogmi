Rails.application.routes.draw do
  resources :features, only: [:index] do
    member do
      post '/create_message', to: 'features#create_message'
      get 'comments', to: 'features#comments'
    end
  end
  #get 'features/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
