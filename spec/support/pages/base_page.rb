class BasePage < SitePrism::Page
  # We can use these elements on all pages
  element :success_flash, '.alert-success'
  element :error_flash, '.alert-danger'
end
