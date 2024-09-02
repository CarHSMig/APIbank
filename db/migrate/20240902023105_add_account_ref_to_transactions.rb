class AddAccountRefToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_reference :transactions, :account, null: false, foreign_key: true
  end
end
