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
    require 'pry'; binding.pry
    merchant = Merchant.find(params[:merchant_id])
    if merchant.update(merchant_params) && merchant_params[:merchant_status].blank?
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:notice] = "Merchant successfully updated."
    elsif merchant_params[:merchant_status].blank?
      redirect_to "/admin/merchants/#{merchant.id}/edit"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    else  
      redirect_to admin_merchants_path
    end
  end

  private 
  
  def merchant_params
    params.permit(:merchant_id, :name, :status)
  end
end