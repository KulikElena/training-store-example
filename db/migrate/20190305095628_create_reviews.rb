class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :status
      t.text :body
      t.string :title
      t.boolean :verified, defauls: true

      t.integer :score, default: 0
      t.belongs_to :user, index: true
      t.belongs_to :book, index: true

      t.timestamps
    end
  end
end
