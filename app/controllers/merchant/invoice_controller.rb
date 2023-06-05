class Merchant::InvoiceController < ApplicationController
  def show
    @invoice = Invoice.find(params[:invoice_id])
    @revenue = @invoice.total_revenue
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    # require 'pry'; binding.pry
    # @merchant = Merchant.find(params[:merchant_id])
    # @invoice = Invoice.find(params[:invoice_id])
    # redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice1.id}"
  end
end