class AddColumsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :title, :string
    add_column :books, :price, :float
    add_column :books, :description, :string
    add_column :books, :quantity, :integer
    add_column :books, :sold, :integer
    add_column :books, :width, :float
    add_column :books, :height, :float
    add_column :books, :depth, :float
    add_column :books, :material, :string
    add_column :books, :publication_year, :integer
  end
end
