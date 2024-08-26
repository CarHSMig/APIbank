class DBfix < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :registration_date, :date
    remove_column :clients, :string
  end
end
