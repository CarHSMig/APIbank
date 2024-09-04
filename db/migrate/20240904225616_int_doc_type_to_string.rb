class IntDocTypeToString < ActiveRecord::Migration[7.1]
  def change
    change_column :accounts, :doc_type, :integer
  end
end
