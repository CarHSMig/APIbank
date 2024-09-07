class AddNewBalance < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :balance_before, :decimal
  end
end
