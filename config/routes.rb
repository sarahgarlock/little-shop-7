Rails.application.routes.draw do
  get "/", to: "application#welcome"
  
  get "/admin", to: "admin/dashboard#index"

  namespace :admin do 
    resources :merchants, except: :destroy
    resources :invoices, only: [:index, :show, :update]
  end
  
  patch "/merchants/:merchant_id/items", to: "merchant/items#update_status"
  
  resources :merchants do
    resources :items, only: [:new, :create, :index, :show, :edit, :update], controller: "merchant/items"
    resources :invoices, only: [:index, :show], controller: "merchant/invoice"
    resources :invoice_items, only: [:update], controller: "merchant/invoice_items"
    resources :dashboard, only: [:index], controller: "merchant/dashboard"
  end
end
