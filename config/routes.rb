Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :projects do
    resources :project_participants, only: %i[index new create def destroy]
  end
  delete '/projects/:id', to: "projects#destroy", as: :projects_destroy
end
