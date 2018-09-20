Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#index"
  resources :pages, only: [:index, :show]
  # get 'registration', to: 'pages#show'
  get '/:path', to: 'pages#show'
end
