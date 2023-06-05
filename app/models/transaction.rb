class Transaction < ApplicationRecord
  belongs_to :invoice
  enum result: {failed: 0, success: 1}
end
