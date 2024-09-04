class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts, if_not_exists: true do |t|
      t.string :account_number
      t.decimal :current_value
      t.date :opening_date
      t.timestamps
    end
  end
end
