class Merchant::InvoiceController < ApplicationController
  def show
    @invoice = Invoice.find(params[:invoice_id])
    @revenue = @invoice.total_revenue(@invoice)
  end
end