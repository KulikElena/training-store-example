class Book < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: %i[finders slugged]

  has_many :books_authors, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :authors, through: :books_authors
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders, through: :order_items

  belongs_to :category
end
