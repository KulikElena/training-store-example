module BooksHelper
  include Pagy::Frontend

  def book_cover(book)
    book.images.first_or_initialize.image.url
  end

  def user_cover(user)
    user.avatar || ActionController::Base.helpers.asset_path('user/default.png')
  end

  def no_books_image
    ActionController::Base.helpers.asset_path('fallback/no_books.jpg')
  end

  def categories
    Category.all
  end

  def all_books_quantity
    Book.all.count
  end
end
