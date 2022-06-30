Rails.application.routes.draw do

  #halaman utama
  get 'articles/index'
  root "articles#index"

  #register
  get '/register', to: 'auth#form_register', as: 'form_register'
  post '/register', to: 'auth#register', as: 'register_post'

  #login
  get '/Login', to: 'auth#form_login', as: 'form_login'
  post '/Login', to: 'auth#login', as: 'login_post'

  #create user
  get '/add', to: 'auth#form_user', as: 'form_user'
  post '/add', to: 'auth#user', as: 'user_post'

  resources :auth
  
  #create role    
  get '/role', to: 'role#form_role', as: 'form_role'
  post '/role', to: 'role#create', as: 'create_post'

  # logout
  delete '/logout/:id', to: 'auth#logout', as: 'user_logout'

  #articles
  resources :articles do
    resources :comments
  end

end
