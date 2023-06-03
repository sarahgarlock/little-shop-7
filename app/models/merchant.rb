class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true
  enum status: {enabled: 0, disabled: 1}
  
  # def top_customers(merchant)
  #   Customer.joins(invoices: :items)
  #   .where(items: { merchant_id: merchant.id })
  #   .distinct
  # end
end