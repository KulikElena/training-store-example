class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :danger, :info, :warning
  helper_method :current_order

  def authenticate_active_admin_user!
    authenticate_user!
    redirect_visitor unless current_user.admin
  end

  def current_order
    Order.where(user_id: current_user.id).in_progress.first_or_create do |order|
      order.user_id = current_user.id
    end
  end

  private

  def redirect_visitor
    flash[:alert] = I18n.t('application_controller.no_admin_access')
    redirect_to root_path
  end
end
