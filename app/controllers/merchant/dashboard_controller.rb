class Merchant::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_customers = Customer.top_customers(@merchant.id)
    @items = @merchant.items_ready_to_ship
    # require 'pry'; binding.pry
  end
end
