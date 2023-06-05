class Merchant::InvoiceController < ApplicationController
  def show
    @invoice = Invoice.find(params[:invoice_id])
    @revenue = @invoice.total_revenue
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
#     @merchant = Merchant.find(params[:merchant_id])
#     @invoice = Invoice.find(params[:invoice_id])
# # require 'pry'; binding.pry
#     if params[:itemstatus] == 1
#       @invoice.item.update(status: 0)
#     elsif params[:itemstatus] == 0
#       @invoice.item.update(status: 1)
#     end
#     @invoice.save
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end
end