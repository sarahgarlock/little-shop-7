class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items

  # def top_customers(merchant)
  #   Customer.joins(invoices: :items)
  #   .where(items: { merchant_id: merchant.id })
  #   .distinct
  # end

  def items_ready_to_ship
    items.joins(:invoice_items)
    .where.not(invoice_items: { status: 2 })
  end
end