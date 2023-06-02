class Merchant::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_customers = @merchant.top_customers(@merchant)
  end
end