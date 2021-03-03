Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :profiles, only: %i[show]
  resources :projects do
    resources :participants, only: %i[index new create def destroy]
  end
  delete '/projects/:id', to: "projects#destroy", as: :projects_destroy
end
