class HandleOrderItemsService
  def destroy(item_id, current_order)
    OrderItem.find_by(book_id: item_id, order_id: current_order.id).destroy
    UpdateOrderTotalService.new.call(current_order.id)
  end

  def update(params, current_order)
    update_item(params, current_order) if params[:value].to_i.positive?
  end

  private

  def update_item(params, current_order)
    current_order.order_items.find_by(book_id: params[:book_id]).update(quantity: params[:value])
    UpdateOrderTotalService.new.call(current_order.id)
  end
end
