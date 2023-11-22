Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about"

  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end
  
  resources :users do
    resource :relationship, only: [:create, :destroy]
    member do
      get 'following' => "relationships#following", as:"following"
      get 'followers' => "relationships#followers", as:"followers"
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end