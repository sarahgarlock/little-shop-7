class Merchant::InvoiceController < ApplicationController
  def show
    @invoice = Invoice.find(params[:invoice_id])
    @revenue = @invoice.total_revenue(@invoice)
    # @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    
  end
end