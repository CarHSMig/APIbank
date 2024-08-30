class Alteracaocolunaclient < ActiveRecord::Migration[7.1]
  def change
    change_column :clients, :doc_number, :string
  end
end
