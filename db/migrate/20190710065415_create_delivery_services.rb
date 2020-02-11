class CreateDeliveryServices < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_services do |t|
      t.string :name
      t.decimal :price, precision: 7, scale: 2
      t.integer :from_days
      t.integer :to_days
      t.timestamps
    end
  end
end
