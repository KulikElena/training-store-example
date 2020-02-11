class AddCheckoutToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :checkout, :text, default: 'address'
    add_column :orders, :number, :text
  end
end
