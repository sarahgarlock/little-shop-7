class Merchant::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_customers = Customer.top_customers(@merchant.id)
  end
end
