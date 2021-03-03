Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :profiles, only: %i[show]
  resources :projects do
    resources :participants, only: %i[index new create def destroy]
  end

  resources :profiles do
    get '/new_join_request/:project_id', to: 'projects#new_join_request', as: :new_join_request
  end

  delete '/projects/:id', to: "projects#destroy", as: :projects_destroy
end
