class Admin::DashboardController < ApplicationController
  def index
    @customers = Customer.all
    @invoice_ids = InvoiceItem.incomplete_invoice_ids
  end
end