class Merchant::InvoiceController < ApplicationController
  def show
    @invoice = Invoice.find(params[:invoice_id])
    @inv_items = @invoice.invoice_items
    @revenue = @invoice.total_revenue
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
    @invoice_item = @invoice.invoice_items.first
    @invoice_item.update(status:params[:itemstatus])
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end
end
