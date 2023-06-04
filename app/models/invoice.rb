class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: {"cancelled" => 0, "completed" => 1, "in progress" => 2}

  def self.incomplete
    where(status: :incomplete)
  end
  
  def self.order_by_creation_date
    order(created_at: :asc)
  end

  def self.incomplete_invoice_ids
    joins(:invoice_items).select("invoices.*").where.not('invoice_items.status = 2').distinct 
  end
end
