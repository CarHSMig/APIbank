class AddNewBalance < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :new_balance, :decimal
  end
end
