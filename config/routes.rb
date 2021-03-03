Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :profiles, only: %i[show]

  resources :projects, except: %i[delete] do
    resources :participants, only: %i[index edit destroy]
    post '/participant/create', to: 'participants#create', as: :participant_create
  end

  resources :project, only: [:show] do
    post '/new_join_request/:project_id', to: 'projects#new_join_request', as: :new_join_request
    post '/join_request_authorize/:id', to: 'projects#join_request_authorize', as: :join_request_authorize
    post '/join_request_refuse/:id', to: 'projects#join_request_refuse', as: :join_request_refuse
    get '/joint_requests_pending', to: 'projects#pending_join_requests', as: :pending_join_requests
  end

  delete '/projects/:id', to: "projects#destroy", as: :project_destroy
end
