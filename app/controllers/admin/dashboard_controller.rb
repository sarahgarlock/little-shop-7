class Admin::DashboardController < ApplicationController
  def index
    @customers = Customer.all
    @invoices = Invoice.incomplete_invoice_ids.order_by_creation_date
  end
end