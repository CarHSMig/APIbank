class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :string
      t.string :password
      t.date :birth_date
      t.integer :doc_type
      t.integer :doc_number

      t.timestamps
    end
  end
end
