class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: {packaged: 0, pending: 1, shipped: 2}

  def self.incomplete_invoice_ids
    joins(:invoice).where.not(status: 2).distinct.pluck(:invoice_id)
  end
end
