class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.text :status
      t.belongs_to :user, index: true, foreign_key: true
      t.references :coupon
      t.timestamps
    end
  end
end
