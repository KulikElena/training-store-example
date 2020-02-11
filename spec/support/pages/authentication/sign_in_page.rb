class SignInPage < BasePage
  set_url '/users/sign_in'

  element :email, '#user_email'
  element :password, '#user_password'
  element :login_button, '[name="commit"]'
end
