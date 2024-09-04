class AddClientColumnsToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :name, :string
    add_column :accounts, :password, :string
    add_column :accounts, :birth_date, :date
    add_column :accounts, :doc_type, :integer
    add_column :accounts, :doc_number, :string
    add_column :accounts, :registration_date, :date
  end
end
