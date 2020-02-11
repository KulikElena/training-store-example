class UpdateUserService
  def call(params, user)
    return update_email(params, user) if params.include?('email_form')

    update_password(params, user) if params.include?('password_form')
  end

  def update_email(params, user)
    user.update(email: email_params(params)[:email])
  end

  def update_password(params, user)
    user.update_with_password(password_params(params))
  end

  def email_params(params)
    params.require(:email_form).permit(:email)
  end

  def password_params(params)
    params.require(:password_form).permit(:current_password,
                                          :password,
                                          :password_confirmation)
  end
end
