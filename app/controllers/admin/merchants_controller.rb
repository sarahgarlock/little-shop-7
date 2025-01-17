class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @top_merchants = Merchant.top_by_revenue(5)
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update_status(params[:status])
    if merchant.update(merchant_params) && params[:merchant_status].blank?
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:notice] = "Merchant successfully updated."
    elsif params[:merchant_status].blank?
      redirect_to "/admin/merchants/#{merchant.id}/edit"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    else 
      redirect_to admin_merchants_path
    end
  end

  def new
    @merchant = Merchant.new
  end

  def create
    Merchant.create!(merchant_params)
    redirect_to admin_merchants_path
  end

  private 
  
  def merchant_params
    params.permit(:name)
  end
end