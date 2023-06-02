class Merchant::DashboardController < ApplicationController
  def index
    # require 'pry'; binding.pry
    @merchants = Merchant.find(params[:merchant_id])
  end
end