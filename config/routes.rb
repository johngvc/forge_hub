Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'

  get '/contact', to: 'pages#contact'

  resources :profiles, only: %i[show]

  resources :chat_messages, only: [:new, :create]

  get "/linkedinprofile", to: 'profiles#showlinkedin'

  get '/contact', to: 'pages#contact'

  resources :projects, except: %i[delete] do
    resources :participants, only: %i[index]
    get '/participant/create', to: 'participants#create', as: :participant_create
    delete '/participant/destroy/:participant_id', to: 'participants#destroy', as: :participant_destroy
  end

  patch '/participants/update_status/:participant_id', to: 'participants#update_status', as: :participants_update_status

  resources :projects, only: [:show] do
    post '/join_request_do', to: 'projects#join_request_do', as: :join_request_do
    post '/join_request_authorize/:join_request_id', to: 'projects#join_request_authorize', as: :join_request_authorize
    post '/join_request_refuse/:join_request_id', to: 'projects#join_request_refuse', as: :join_request_refuse
  end

  get '/reply_to_join_request', to: 'projects#reply_to_join_request', as: :reply_to_join_request

  delete '/projects/:id', to: "projects#destroy", as: :project_destroy

end
