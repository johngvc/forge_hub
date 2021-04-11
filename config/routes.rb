Rails.application.routes.draw do

  get 'errors/not_found'
  get 'errors/internal_server_error'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'

  get '/contact', to: 'pages#contact'

  post '/message', to: 'messages#create'

  post '/chatroom', to: 'chatrooms#create'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :chatrooms, only: [:index, :show]
      get 'chatrooms/user_chatrooms/:user_id', to: 'chatrooms#user_chatrooms'
    end
  end

  get '/search_result', to: 'pages#search_results'

  resources :profiles, only: %i[show index]

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
    get '/join_request_pending', to: 'projects#join_request_pending', as: :join_request_pending
  end

  get '/reply_to_join_request', to: 'projects#reply_to_join_request', as: :reply_to_join_request

  get 'chat_message_from_card', to: 'chat_messages#chat_message_from_card', as: :chat_message_from_card

  post 'send_chat_message_from_card', to: 'chat_messages#send_chat_message_from_card', as: :send_chat_message_from_card

  post 'send_reply_to_join_request', to: 'projects#send_reply_to_join_request', as: :send_reply_to_join_request

  get 'reply_from_message_card', to: 'chat_messages#reply_from_message_card', as: :reply_from_message_card

  post 'send_reply_from_message_card', to: 'chat_messages#send_reply_from_message_card', as: :send_reply_from_message_card

  get 'reply_from_message_card_big', to: 'chat_messages#reply_from_message_card_big', as: :reply_from_message_card_big

  post 'send_reply_from_message_card_big', to: 'chat_messages#send_reply_from_message_card_big', as: :send_reply_from_message_card_big

  get 'reply_from_user_card_index', to: 'chat_messages#reply_from_user_card_index', as: :reply_from_user_card_index

  post 'send_reply_from_user_card_index', to: 'chat_messages#send_reply_from_user_card_index', as: :send_reply_from_user_card_index

  delete '/projects/:id', to: "projects#destroy", as: :project_destroy

  resources :bootcamps, only: [:new, :create]

end
