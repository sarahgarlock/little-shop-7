class Merchant::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
end