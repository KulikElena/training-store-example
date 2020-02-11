class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :number, null: false
      t.integer :cvv, null: false
      t.string :name, null: false
      t.string :expiry_date, null: false
      t.references :order
      t.timestamps
    end
  end
end
