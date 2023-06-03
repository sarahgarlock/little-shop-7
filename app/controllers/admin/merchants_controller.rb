class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:id])
    Merchant.update(merchant_params)
  end

  private 
  
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end