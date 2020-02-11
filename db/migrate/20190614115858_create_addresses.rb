class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :zip
      t.string :country
      t.string :phone
      t.string :type
      t.boolean :use_billing_address, default: false

      t.references :addressable, polymorphic: true
      t.timestamps
    end
  end
end
