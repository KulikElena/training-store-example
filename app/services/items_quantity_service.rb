class ItemsQuantityService
  def call(guest_items, current_user, current_order)
    return all_items(guest_items, current_order) if current_user

    guest_items ? guest_items.count : 0
  end

  private

  def all_items(guest_items, current_order)
    create_item(guest_items, current_order) if guest_items
    current_order.order_items.count
  end

  def create_item(guest_items, current_order)
    guest_items.each do |book_id, quantity|
      CreateOrderItemService.new.call(current_order.id, book_id: book_id, quantity: quantity)
    end
  end
end
