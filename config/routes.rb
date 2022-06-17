Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  #localhost:3000/Dashboard
  scope '/Dashboard' do

    #localhost:3000/Dashboard
    get '/', to: 'dashboard#index', as: 'dashboard_index'
  end 
end
