Rails.application.routes.draw do
  devise_for :users
  resources :products
  root "products#index"
  post "checkout/create", to: "checkout#create"
  post "payment/create", to: "payment#create_payment_method"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :invoices, except: [:destroy]
  resources :products do
    member do
      get 'success', to: 'checkout#success', as: :success
      get 'cancel', to: 'checkout#cancel', as: :cancel
    end
  end
end
