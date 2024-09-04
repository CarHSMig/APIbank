class RemoveIndexFromTransactions < ActiveRecord::Migration[7.1]
  def change
    remove_index :transactions, name: "index_transactions_on_account_id"
  end
end

