class OrderItemsController < ApplicationController
  def create
    user_signed_in? ? add_item_to_order : save_guest

    redirect_to request.headers['HTTP_REFERER']
  end

  def update
    current_user ? HandleOrderItemsService.new.update(order_item_params, current_order) : add_item_to_session

    redirect_to cart_path
  end

  def destroy
    current_user ? HandleOrderItemsService.new.destroy(order_item_params[:id], current_order) : remove_from_session

    redirect_to cart_path
  end

  private

  def remove_from_session
    session[:guest_items].delete(params[:id])
  end

  def add_item_to_session
    session[:guest_items][params[:book_id]] = order_item_params[:value]
  end

  def order_item_params
    params.permit(:quantity, :book_id, :value, :id)
  end

  def add_item_to_order
    flash[:success] = t('order_items.added_to_card') if CreateOrderItemService.new.call(current_order.id, order_item_params)
  end

  def save_guest
    session[:guest_items] ||= {}
    session[:guest_items][params[:book_id]] = update_item
  end

  def update_item
    session[:guest_items]&.key?(params[:book_id]) ? update_session : params[:quantity]
  end

  def update_session
    (session[:guest_items][params[:book_id]].to_i + params[:quantity].to_i).to_s
  end
end
