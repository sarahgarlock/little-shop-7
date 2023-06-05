class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: {"cancelled" => 0, "completed" => 1, "in progress" => 2}

  # def self.incomplete
  #   where(status: :incomplete)
  # end
  
  def self.order_by_creation_date
    order(created_at: :asc)
  end

  def self.incomplete_invoice_ids
    joins(:invoice_items).select("invoices.*").where.not('invoice_items.status = 2').distinct 
  end

  def total_revenue
    invoice_items.sum('quantity * unit_price')
  end

  def quantity_of_item(item)
    invoice_item = invoice_items.find_by(item_id: item.id)
    if invoice_item != nil
      invoice_item.quantity
    end
  end

  def price_sold(item)
    invoice_item = invoice_items.find_by(item_id: item.id)
    if invoice_item != nil
      invoice_item.unit_price
    end
  end

  def invoice_item_status(item)
    invoice_item = invoice_items.find_by(item_id: item.id)
    if invoice_item != nil
      invoice_item.status
    end
  end
end
