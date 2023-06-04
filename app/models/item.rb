class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  enum status: {enabled: 0, disabled: 1}
  
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :merchant_id, presence: true

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