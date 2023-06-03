Rails.application.routes.draw do
  get "/", to: "application#welcome"

  get "/admin", to: "admin/dashboard#index"

  get "/admin/merchants", to: "admin/merchants#index"
  get "/admin/merchants/:merchant_id", to: "admin/merchants#show"
  get "/admin/merchants/:merchant_id/edit", to: "admin/merchants#edit"
  patch "/admin/merchants/:merchant_id", to: "admin/merchants#update"
  
  get "/admin/invoices", to: "admin/invoices#index"

  get "/merchants/:merchant_id/dashboard", to: "merchant/dashboard#index"
end
