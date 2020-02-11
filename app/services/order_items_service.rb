class OrderItemsService
  def initialize(current_user, guest_items)
    @current_order = current_user.orders.in_progress.first if current_user
    @current_user = current_user
    @guest_items = guest_items
    @items = {}
  end

  def call
    @current_user ? items_of_user : guest_items
    @items
  end

  private

  def guest_items
    items_of_guest if @guest_items
  end

  def items_of_user
    @current_order.order_items.includes(:book).each do |item|
      @items[item.book] = item.quantity
    end
  end

  def items_of_guest
    books = Book.where(id: @guest_items.keys)
    @guest_items.each do |book_id, quantity|
      @items[books.find_by(id: book_id)] = quantity
    end
  end
end
