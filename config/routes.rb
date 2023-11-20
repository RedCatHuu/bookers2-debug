Rails.application.routes.draw do
  get 'create/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about"

  resources :books do
    resource :favorite, only: [:create, :destroy]
  end
  resources :users
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end