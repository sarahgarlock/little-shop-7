class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  validates :name, presence: true
  enum status: {enabled: 0, disabled: 1}

  def items_ready_to_ship
    items.joins(:invoice_items)
    .where.not(invoice_items: { status: 2 })
    .order('invoice_items.created_at ASC')
  end

  def update_status(code)
    if code == "0"
      enabled!
    elsif code == "1"
      disabled!
    else 
      "invalid code"
    end
  end

  def self.top_by_revenue(limit)
    joins(invoices: :invoice_items)
      .select('merchants.id, merchants.name, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
      .group(:id)
      .order('total_revenue DESC')
      .limit(limit)
  end

  def best_day
    best_date = 
    invoice_items
    .joins(invoice: :transactions)
    .select("DATE(invoices.created_at) as date, 
      sum(transactions.result), 
      sum(invoice_items.quantity*invoice_items.unit_price) as revenue")
    .group("date")
    .having("sum(transactions.result) > 0")
    .order("revenue desc")
    .first
    
    if best_date != nil 
      best_date.date
    else
      nil
    end
  end

  def total_revenue
    self.invoice_items.sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.top_by_revenue(limit)
    joins(invoices: [:invoice_items, :transactions])
      .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
      .where(transactions: { result: 1 })
      .group("merchants.id")
      .order('total_revenue DESC')
      .limit(5)
  end
end