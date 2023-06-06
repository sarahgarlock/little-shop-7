class Merchant::InvoiceController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end
  def show
    @invoice = Invoice.find(params[:invoice_id])
    @inv_items = @invoice.invoice_items
    @revenue = @invoice.total_revenue
    @merchant = Merchant.find(params[:merchant_id])
  end
end
