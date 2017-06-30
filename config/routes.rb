Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  namespace :api do
    namespace :v1  do
      devise_for :users
      
      resources :feeds
      resources :entries
    end
  end
end
