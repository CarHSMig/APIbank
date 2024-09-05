class IntDocTypeToString < ActiveRecord::Migration[7.1]
  def change
    change_column :accounts, :doc_type, :string
    remove_column :transactions, :accounts_id
  end
end
