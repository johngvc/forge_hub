Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'

  resources :profiles, only: %i[show]

  resources :projects, except: %i[delete] do
    resources :participants, only: %i[index edit update destroy]
    get '/participant/create', to: 'participants#create', as: :participant_create
  end

  resources :projects, only: [:show] do
    post '/join_request_do', to: 'projects#join_request_do', as: :join_request_do
    post '/join_request_authorize/:join_request_id', to: 'projects#join_request_authorize', as: :join_request_authorize
    post '/join_request_refuse/:join_request_id', to: 'projects#join_request_refuse', as: :join_request_refuse


  end

  delete '/projects/:id', to: "projects#destroy", as: :project_destroy
end
