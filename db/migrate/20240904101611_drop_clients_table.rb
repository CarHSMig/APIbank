class DropClientsTable < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :accounts, :clients
    drop_table :clients
  end
end
