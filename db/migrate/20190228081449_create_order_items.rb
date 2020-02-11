class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.belongs_to :book, index: true, foreign_key: true
      t.belongs_to :order, index: true, foreign_key: true
      t.integer :quantity, default: 0
      t.timestamps
    end
  end
end
