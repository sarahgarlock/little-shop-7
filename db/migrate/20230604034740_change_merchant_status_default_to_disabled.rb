class ChangeMerchantStatusDefaultToDisabled < ActiveRecord::Migration[7.0]
  def change
    change_column_default :merchants, :status, from: 0, to: 1
  end
end
