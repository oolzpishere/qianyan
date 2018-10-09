Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#index"
  resources :pages, only: [:index, :show]
  resources :dvd_results,  only: [:index, :show, :create]
  resources :redirects, only: [:index, :show]

  # for last match. get 'registration', to: 'pages#show'
  get '/:path', to: 'pages#show'
end
