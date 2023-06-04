Rails.application.routes.draw do
  get "/", to: "application#welcome"

  get "/admin", to: "admin/dashboard#index"

  get "/admin/merchants", to: "admin/merchants#index"
  patch "/admin/merchants", to: "admin/merchants#update"
  get "/admin/merchants/:merchant_id", to: "admin/merchants#show"
  get "/admin/merchants/:merchant_id/edit", to: "admin/merchants#edit"
  patch "/admin/merchants/:merchant_id", to: "admin/merchants#update"
  
  get "/admin/invoices", to: "admin/invoices#index"
  get '/admin/invoices/:id', to: 'admin/invoices#show', as: 'admin_invoice'

  get "/merchants/:merchant_id/dashboard", to: "merchant/dashboard#index"

  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchant/invoice#show"

  get "/merchants/:merchant_id/items", to: "merchant/items#index"
  get "/merchants/:merchant_id/items/:item_id", to: "merchant/items#show"
  get "/merchants/:merchant_id/items/:item_id/edit", to: "merchant/items#edit"
  patch "/merchants/:merchant_id/items/:item_id", to: "merchant/items#update"
  patch "/merchants/:merchant_id/items", to: "merchant/items#update"
end
