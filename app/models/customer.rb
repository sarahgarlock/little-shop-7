class Customer < ApplicationRecord
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
end
