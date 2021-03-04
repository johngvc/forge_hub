Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root to: 'pages#home'

  resources :profiles, only: %i[show]

  resources :projects, except: %i[delete] do
    resources :participants, only: %i[index edit destroy]
    post '/participant/create', to: 'participants#create', as: :participant_create
  end

  resources :projects, only: [:show] do
    post '/new_join_request/:project_id', to: 'projects#new_join_request', as: :new_join_request
    post '/join_request_authorize/:id', to: 'projects#join_request_authorize', as: :join_request_authorize
    post '/join_request_refuse/:id', to: 'projects#join_request_refuse', as: :join_request_refuse
    get '/join_requests_pending', to: 'projects#pending_join_requests', as: :pending_join_requests
  end

  delete '/projects/:id', to: "projects#destroy", as: :project_destroy
end
