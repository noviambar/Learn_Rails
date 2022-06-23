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

  # logout
  delete '/logout/:id', to: 'auth#logout', as: 'user_logout'

  #articles
  resources :articles do
    resources :comments
  end

end
