class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_5
    order('COUNT(customers.invoices.transactions) DESC').limit(5)
  end
end