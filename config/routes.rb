Rails.application.routes.draw do
  root "products#index"
  resources :products
  post "checkout/create", to: "checkout#create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :invoices, except: [:destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
