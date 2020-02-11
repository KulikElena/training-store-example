class SummaryService
  def call(current_user, guest_items, current_order)
    current_user ? user_summary(current_order) : guest_summary(guest_items, current_user)
  end

  private

  def user_summary(current_order)
    coupon_value = 0
    subtotal = current_order.total
    { coupon: coupon_value, subtotal: subtotal, total: total(subtotal, coupon_value, current_order) }
  end

  def guest_summary(guest_items, current_user)
    coupon_value = 0
    subtotal = summary_subtotal(current_user, guest_items).round(2)
    { coupon: coupon_value, subtotal: subtotal, total: total(subtotal, coupon_value) }
  end

  def summary_subtotal(current_user, guest_items)
    OrderItemsService.new(current_user, guest_items).call.inject(0) { |total, (book, num)| total + (book.price * num.to_i) }
  end

  def total(subtotal, coupon_value, order = nil)
    total = subtotal > coupon_value ? (subtotal - coupon_value).round(2) : subtotal
    total = order_total(total, order) if order
    total.round(2)
  end

  def order_total(total, order)
    total = + order.delivery_service.price unless order.address?
    total
  end
end
