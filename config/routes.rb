Rails.application.routes.draw do
  get "/", to: "application#welcome"

  # get "/admin", to: "admin/dashboard#index"
  resources :admin, only: [:index], to: "admin/dashboard#index"

  get "/admin/merchants", to: "admin/merchants#index"
  patch "/admin/merchants", to: "admin/merchants#update"
  get "/admin/merchants/new", to: "admin/merchants#new"
  post "/admin/merchants", to: "admin/merchants#create"
  get "/admin/merchants/:merchant_id", to: "admin/merchants#show"
  get "/admin/merchants/:merchant_id/edit", to: "admin/merchants#edit"
  patch "/admin/merchants/:merchant_id", to: "admin/merchants#update"
  # # namespace :admin do 
  #   resources :merchants, :invoices
  # end
  # resources :admin do
  #   resources :merchants
  #     resources :merchant_id
  # end
  # namespace :admin do
  #   resources :invoices
  #   resources :merchants do  
  #     resources :merchant_id
  #   end
  # end
  get "/admin/invoices", to: "admin/invoices#index"
  get "/admin/invoices/:id", to: "admin/invoices#show", as: "admin_invoice"
  patch "/admin/invoices/:id", to: "admin/invoices#update"

  # namespace :admin do 
  #   resources :invoices
  # end


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
  
  patch "/merchants/:merchant_id/items", to: "merchant/items#update_status"
  
  resources :merchants do
    resources :items, controller: "merchant/items"
    resources :invoices, controller: "merchant/invoice"
    resources :invoice_items, controller: "merchant/invoice_items"
    resources :dashboard, only: [:index], controller: "merchant/dashboard"
  end
  # resources :merchants do
  #   resources :items, controller: "merchants/items"
  #   resources :invoices, only: [:index, :show], controller: 'merchants/invoices'
  # end

  #   get "/merchants/:merchant_id/dashboard", to: "merchant/dashboard#index"

  
  # resources :merchants do
  #   resources :items, controller: "merchants/items" 
  #   resources :invoices, controller: "merchants/invoices" 
  #   resources :dashboard, only: [:index]
  # end

  # resources :merchants do
  #   resources :invoices, :items do
  #     member do
  #       patch :update_status
  #     end
  #   end
  #   resources :dashboard, only: [:index]
  # end
end
