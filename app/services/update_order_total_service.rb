class UpdateOrderTotalService
  def call(order_id)
    update_total(Order.find_by(id: order_id))
  end

  private

  def update_total(order)
    new_total = order.order_items.includes(:book).inject(0) { |total, item| total + (item.quantity * item.book.price) }
    order.update(total: new_total)
  end
end
