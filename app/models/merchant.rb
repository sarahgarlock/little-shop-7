class Merchant < ApplicationRecord
  has_many :items

  def top_customers(merchant)
    customers = Customer.joins(invoices: :items)
    .where(items: { merchant_id: merchant.id })
    .distinct
    require 'pry'; binding.pry
  end
end