Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/signup' => 'signup#register_account', format: :json
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :feeds
      resources :entries
    end
  end
end
