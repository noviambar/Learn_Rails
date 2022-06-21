Rails.application.routes.draw do
  get 'articles/index'
  root "articles#index"
  # get 'articles/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get "/articles", to: "articles#index"
  # #Menampilkan article berdasarkan id
  # get "articles/:id", to: "articles#show"

  resources :articles do
    resources :comments
  end

end
