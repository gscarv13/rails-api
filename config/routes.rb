Rails.application.routes.draw do
  # This will add namespace to our route, meaning  the index is now /api/v1/books
  # The version is important because that way you can update your API without breaking
  # applications which we don't have control
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :create, :destroy]      

      post '/authenticate', to: 'authentication#create'
    end
  end
end
