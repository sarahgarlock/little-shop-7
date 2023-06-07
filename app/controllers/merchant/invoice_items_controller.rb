class Merchant::InvoiceItemsController < ApplicationController
  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.update(status:params[:itemstatus])
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice_item.invoice.id}"
  end
end
