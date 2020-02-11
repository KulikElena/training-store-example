class CreateOrderItemService
  def call(order_id, params)
    item = OrderItem.find_by(order_id: order_id, book_id: params[:book_id])
    item ? update_order_item(item, params, order_id) : create_order_item(order_id, params)
    UpdateOrderTotalService.new.call(order_id)
  end

  private

  def create_order_item(order_id, params)
    OrderItem.create(order_id: order_id, book_id: params[:book_id], quantity: params[:quantity].to_i)
  end

  def update_order_item(item, params, order_id)
    OrderItem.find_by(order_id: order_id, book_id: params[:book_id]).update(quantity: calculate_quantity(item, params))
  end

  def calculate_quantity(item, params)
    item.quantity + params[:quantity].to_i
  end
end
