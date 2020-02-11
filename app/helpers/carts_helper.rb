module CartsHelper
  def order_summary
    order = current_user ? current_order : nil
    SummaryService.new.call(current_user, session[:guest_items], order)
  end
end
