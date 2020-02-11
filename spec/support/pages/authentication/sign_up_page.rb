class SignUpPage < BasePage
  set_url '/users/sign_up'

  element :email, '#user_email'
  element :password, '#user_password'
  element :password_confirmation, '#user_password_confirmation'
  element :sign_up_button, '[name="commit"]'
end
