class Author < ApplicationRecord
  has_many :booksAuthors, dependent: :destroy
  has_many :books, through: :booksAuthors

  validates :first_name, :last_name, presence: true

  def full_name
    first_name + ' ' + last_name
  end
end
