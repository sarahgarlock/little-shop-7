class Admin::DashboardController < ApplicationController
  def index
    @invoice_ids = InvoiceItem.incomplete_invoice_ids
  end
end