  class AddDeliverToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :delivery_service, null: true
  end
end
