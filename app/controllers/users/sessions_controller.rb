class Users::SessionsController < Devise::SessionsController
  after_action :apply_session_to_order, only: :create

  def create
    super
  end

  def after_sign_in_path_for(_resource)
    current_user.admin ? admin_root_path : root_path
  end

  def apply_session_to_order
    session[:guest_items]&.each do |book_id, quantity|
      CreateOrderItemService.new.call(current_order.id, book_id: book_id, quantity: quantity)
    end
  end
end
