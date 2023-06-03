Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "application#welcome"

  get "/admin", to: "admin/dashboard#index"
  get "/admin/merchants", to: "admin/merchants#index"
  get "/admin/merchants/:merchant_id", to: "admin/merchants#show"
  get "/admin/merchants/:merchant_id", to: "admin/merchants#edit"
  patch "/admin/merchants", to: "admin/merchants#update"
  get "/admin/invoices", to: "admin/invoices#index"

  get "/merchants/:merchant_id/dashboard", to: "merchant/dashboard#index"
end
