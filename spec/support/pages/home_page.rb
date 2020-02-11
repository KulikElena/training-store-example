class HomePage < BasePage
  set_url '/'

  element :sign_up_link, 'a[href="/users/sign_up"]'
  element :login_link, 'a[href="/users/sign_in"]'

  element :user_email, '.user_email > a'
  element :logout, '.hidden-xs a[href="/users/sign_out"]'
  element :settings, '.hidden-xs a[href="/settings"]'

  element :filters_title, '#filters h1'
  element :catalog_title, 'h1.general-title-margin'

  element :no_books_title, '#no_books h2'

  element :view_more_button, '#view_more'

  elements :books, '.book_section'
end
