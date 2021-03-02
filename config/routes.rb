Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :projects do
    resources :projects_participants
  end
  delete '/projects/:id', to: "projects#destroy", as: :projects_destroy
end
