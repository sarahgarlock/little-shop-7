class AddStatusToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :status, :integer
  end
end
