module ApplicationHelper
  include BooksHelper
  include CartsHelper

  def items_quantity
    order = current_user ? current_order : nil
    quantity = ItemsQuantityService.new.call(session[:guest_items], current_user, order)
    session[:guest_items].clear if current_user && session[:guest_items]
    quantity
  end
end
