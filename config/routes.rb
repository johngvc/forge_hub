Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root to: 'pages#home'

  resources :profiles, only: %i[show] do
    post '/join_request_authorize/:join_request_id', to: 'profiles#join_request_authorize', as: :join_request_authorize
    get '/joint_requests_pending', to: 'profiles#pending_join_requests', as: :pending_join_requests
  end

  resources :projects, except: %i[delete] do
    resources :participants, only: %i[index new create def destroy]
    get '/new_join_request/:project_id', to: 'projects#new_join_request', as: :new_join_request
  end

  delete '/projects/:id', to: "projects#destroy", as: :project_destroy
end
