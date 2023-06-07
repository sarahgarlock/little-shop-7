class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true 
  validates :status, presence: true
  belongs_to :invoice
  belongs_to :item
  enum status: {packaged: 0, pending: 1, shipped: 2}

end
