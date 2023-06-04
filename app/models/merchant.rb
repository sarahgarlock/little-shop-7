class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
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
end