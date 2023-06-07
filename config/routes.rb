Rails.application.routes.draw do
  get "/", to: "application#welcome"

  resources :admin, only: [:index], to: "admin/dashboard#index"

  
  
  patch "/merchants/:merchant_id/items", to: "merchant/items#update_status"
  
  resources :merchants do
    resources :items, controller: "merchant/items"
    resources :invoices, controller: "merchant/invoice"
    resources :invoice_items, controller: "merchant/invoice_items"
    resources :dashboard, only: [:index], controller: "merchant/dashboard"
  end
end
