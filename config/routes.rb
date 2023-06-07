Rails.application.routes.draw do
  get "/", to: "application#welcome"

  get "/admin", to: "admin/dashboard#index"

  namespace :admin do 
    resources :merchants, except: :destroy
    resources :invoices, only: [:index, :show, :update]
  end

  resources :merchants, shallow: true  do 
    resources :items, controller: "merchants/items"
    resources :dashboard, controller: "merchants/dashboard"
    resources :invoices, controller: "merchants/invoices"
  end

  # get "/merchants/:merchant_id/items/new", to: "merchant/items#new"
  # post "/merchants/:merchant_id/items/new", to: "merchant/items#create"
  # get "/merchants/:merchant_id/dashboard", to: "merchant/dashboard#index"
  # get "/merchants/:merchant_id/invoices", to: "merchant/invoice#index"
  # get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchant/invoice#show"
  # patch "/merchants/:merchant_id/invoice_items/:invoice_item_id", to: "merchant/invoice_items#update"
  # get "/merchants/:merchant_id/items", to: "merchant/items#index"
  # get "/merchants/:merchant_id/items/:item_id", to: "merchant/items#show"
  # get "/merchants/:merchant_id/items/:item_id/edit", to: "merchant/items#edit"
  # patch "/merchants/:merchant_id/items/:item_id", to: "merchant/items#update"
  # patch "/merchants/:merchant_id/items", to: "merchant/items#update_status"
end
