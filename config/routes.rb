Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :projects
  delete '/projects/:id', to: "projects#destroy", as: :projects_destroy
end
