Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "application#welcome"

  get "/admin", to: "admin/dashboard#index"
  get "/admin/merchants", to: "admin/merchants#index"
  get "/admin/invoices", to: "admin/invoices#index"

  get "/merchants/:merchant_id/dashboard", to: "merchant/dashboard#index"
  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchant/invoice#show"
end
