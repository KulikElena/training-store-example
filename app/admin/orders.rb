ActiveAdmin.register Order do
  permit_params :status, :discount
  actions :index, :show, :update, :edit

  controller do
    actions :all, except: :edit
  end

  action_item :to_delivered, only: :show do
    link_to I18n.t('active_admin.delivered'), delivered_admin_order_path(order), method: :put if order.may_to_delivered?
  end

  action_item :to_shipped, only: :show do
    link_to I18n.t('active_admin.shipped'), shipped_admin_order_path(order), method: :put if order.may_to_shipped?
  end

  action_item :to_canceled, only: :show do
    link_to I18n.t('active_admin.canceled'), canceled_admin_order_path(order), method: :put
  end

  index do
    id_column
    column :created_at
    column :status
    actions defaults: false do |order|
      item I18n.t('active_admin.view'), admin_order_path(order)
      item I18n.t('active_admin.shipped'), shipped_admin_order_path(order), method: :put if order.may_to_shipped?
      item I18n.t('active_admin.delivered'), delivered_admin_order_path(order), method: :put if order.may_to_delivered?
      item I18n.t('active_admin.canceled'), canceled_admin_order_path(order), method: :put
    end
  end

  show do
    columns do
      column do
        attributes_table do
          row :user_id
          row :status
          row :number
          row :total
          row :created_at
          row :discount
        end
      end

      column do
        panel I18n.t('active_admin.order_items') do
          order.order_items.each do |item|
            li link_to(I18n.t('active_admin.order_item'), admin_order_item_path(item))
          end
        end
      end
    end
  end

  member_action :canceled, method: :put do
    Order.find_by(id: params[:id]).destroy
    redirect_to admin_orders_path, danger: I18n.t('active_admin.order_shipped')
  end

  member_action :shipped, method: :put do
    order = Order.find_by(id: params[:id])
    if order.may_to_shipped?
      order.to_shipped!
      redirect_to admin_orders_path, danger: I18n.t('active_admin.order_shipped')
    end
  end

  member_action :delivered, method: :put do
    order = Order.find_by(id: params[:id])
    if order.may_to_delivered?
      order.to_delivered!
      redirect_to admin_orders_path, danger: I18n.t('active_admin.order_delivered')
    end
  end
end
