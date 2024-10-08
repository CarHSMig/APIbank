class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :accounts, null: false, foreign_key: true
      t.string :transaction_type
      t.decimal :value
      t.datetime :transaction_date
      t.text :description

      t.timestamps
    end
  end
end
