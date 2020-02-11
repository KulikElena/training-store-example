class AddTotslToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :total, :float, default: 0, scale: 2
  end
end
