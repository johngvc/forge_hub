Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  get '/contact', to: 'pages#contact'
  resources :profiles, only: %i[show]

  get "/linkedinprofile", to: 'profiles#showlinkedin'
  get '/contact', to: 'pages#contact'
  resources :profiles, only: %i[show]

  resources :projects, except: %i[delete] do
    resources :participants, only: %i[index]
    get '/participant/create', to: 'participants#create', as: :participant_create
    delete '/participant/destroy/:participant_id', to: 'participants#destroy', as: :participant_destroy
    patch '/participant/update_status/:participant_id', to: 'participant#update_status', as: :participant_update_status
  end

  resources :projects, only: [:show] do
    post '/join_request_do', to: 'projects#join_request_do', as: :join_request_do
    post '/join_request_authorize/:join_request_id', to: 'projects#join_request_authorize', as: :join_request_authorize
    post '/join_request_refuse/:join_request_id', to: 'projects#join_request_refuse', as: :join_request_refuse
  end

  delete '/projects/:id', to: "projects#destroy", as: :project_destroy
end
