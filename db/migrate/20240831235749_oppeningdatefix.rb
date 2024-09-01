class Oppeningdatefix < ActiveRecord::Migration[7.1]
  def change
    remove_column :accounts, :opening_date, :date
  end
end
