class UpdateAddressService
  def call(params, object)
    billing = update_billing(params, object) if params.include?('billing_address')
    shipping = update_shipping(params, object) if params.include?('shipping_address')
    response(billing, shipping, params)
  end

  private

  def response(billing, shipping, params)
    return [billing, shipping] if params.include?('billing_address') && params.include?('shipping_address')
    return billing if params.include?('billing_address')
    return shipping if params.include?('shipping_address')
  end

  def update_shipping(params, object)
    shipping = if params[:use_billing] == 'true'
                 params[:billing_address][:type] = 'shipping_address'
                 use_billing = true
                 ShippingForm.new(address_params(:billing_address, params))
               else
                 use_billing = false
                 ShippingForm.new(address_params(:shipping_address, params))
               end
    shipping.save_address(object, use_billing)
    shipping
  end

  def update_billing(params, object)
    billing = BillingForm.new(address_params(:billing_address, params))
    billing.save_address(object)
    billing
  end

  def address_params(kind, params)
    params.require(kind.to_sym).permit(:first_name,
                                       :last_name,
                                       :address,
                                       :city,
                                       :zip,
                                       :country,
                                       :phone,
                                       :type)
  end
end
