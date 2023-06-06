class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_5
    select("customers.*").joins(:invoices, :transactions)
    .where("transactions.result = 0").group("customers.id")
    .order("COUNT(transactions.id) DESC").limit(5)
  end

  def count_success_transactions
    transactions.where("transactions.result = 0").count
  end

  def self.top_customers(merchant_id)
    joins(invoices: { invoice_items: { item: :merchant }, transactions: :invoice })
    .where('merchants.id = ?', merchant_id)
    .where("transactions.result = 0")
    .group('customers.id')
    .select('customers.*, SUM(invoice_items.quantity) AS total_quantity')
    .order("COUNT(transactions.id) DESC").limit(5)
  end
end
