class OrderMailer < ApplicationMailer
  default from: ENV['GMAIL_SMTP_USER'],
          template_path: 'mailers/order'

  def order_confirmation(order)
    @user = order.user
    @order = order
    mail to: @user.email, subject: t('mailer.confirmation')
  end
end
