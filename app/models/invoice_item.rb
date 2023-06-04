class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: {packaged: 0, pending: 1, shipped: 2}
end
