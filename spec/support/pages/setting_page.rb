class SettingPage < BasePage
  set_url '/settings'

  # Billing Address
  element :billing_address_first_name, '#billing_address_first_name'
  element :billing_address_last_name, '#billing_address_last_name'
  element :billing_address_address, '#billing_address_address'
  element :billing_address_city, '#billing_address_city'
  element :billing_address_zip, '#billing_address_zip'
  element :billing_address_country, '#billing_address_country'
  element :billing_address_phone, '#billing_address_phone'
  element :billing_address_button, '.billing_address_section [name="commit"]'

  # Shipping Address
  element :shipping_address_first_name, '#shipping_address_first_name'
  element :shipping_address_first_name_validation, '#shipping_address_first_name + .invalid-feedback'
  element :shipping_address_last_name, '#shipping_address_last_name'
  element :shipping_address_last_name_validation, '#shipping_address_last_name + .invalid-feedback'
  element :shipping_address_address, '#shipping_address_address'
  element :shipping_address_address_validation, '#shipping_address_address + .invalid-feedback'
  element :shipping_address_city, '#shipping_address_city'
  element :shipping_address_city_validation, '#shipping_address_city + .invalid-feedback'
  element :shipping_address_zip, '#shipping_address_zip'
  element :shipping_address_zip_validation, '#shipping_address_zip + .invalid-feedback'
  element :shipping_address_country, '#shipping_address_country'
  element :shipping_address_country_validation, '#shipping_address_country + .invalid-feedback'
  element :shipping_address_phone, '#shipping_address_phone'
  element :shipping_address_phone_validation, '#shipping_address_phone + .invalid-feedback'
  element :shipping_address_button, '.shipping_address_section [name="commit"]'

  expected_elements :billing_address_first_name, :billing_address_last_name, :billing_address_address, 
  :billing_address_city, :billing_address_zip, :billing_address_country, :billing_address_phone, 
  :billing_address_button, :shipping_address_first_name, :shipping_address_last_name, :shipping_address_address, 
  :shipping_address_city, :shipping_address_zip, :shipping_address_country, :shipping_address_phone, :shipping_address_button
end
