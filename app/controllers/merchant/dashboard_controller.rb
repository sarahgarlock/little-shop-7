class Merchant::DashboardController < ApplicationController
  def index
    @merchants = Merchant.find(params[:merchant_id])
  end
end