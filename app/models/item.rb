class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  enum status: {enabled: 0, disabled: 1}

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :merchant_id, presence: true

  def self.revenue
    joins(invoice_items: { invoice: :transactions })
    .select('items.id, items.name, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue, SUM(transactions.result) AS total_result')
    .group('items.id')
    .having('SUM(transactions.result) > 0')
    .order('revenue DESC')
    .limit(5)
  end

  def item_rev_dollars
    self.invoice_items[0].quantity * self.invoice_items[0].unit_price
  end

  
end