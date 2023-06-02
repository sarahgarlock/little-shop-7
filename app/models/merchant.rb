class Merchant < ApplicationRecord
  has_many :items

  # def top_customers(merchant)
  #   Customer.joins(invoices: :items)
  #   .where(items: { merchant_id: merchant.id })
  #   .distinct
  # end
end