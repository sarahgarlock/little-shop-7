class Transaction < ApplicationRecord
  validates :cc_num, presence: true, numericality: true
  validates :result, presence: true
  belongs_to :invoice
  has_many :invoice_items, through: :invoice
  enum result: {failed: 0, success: 1}
end
