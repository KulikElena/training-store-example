module FlashesHelper
  def alert_class(string)
    string == I18n.t('flash.alert') ? 'alert-danger' : 'alert-success'
  end
end
