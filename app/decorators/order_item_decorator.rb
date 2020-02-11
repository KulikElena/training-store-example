class OrderItemDecorator < Draper::Decorator
  delegate_all

  MINIMUM_QUANTITY = 1
end
