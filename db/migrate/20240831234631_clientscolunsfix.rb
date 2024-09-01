class Clientscolunsfix < ActiveRecord::Migration[7.1]
  def change
    rename_column :accounts, :clients_id, :client_id
  end
end
