class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.references :clients, null: false, foreign_key: true
      t.string :account_number
      t.decimal :current_value
      t.date :opening_date

      t.timestamps
    end
  end
end
