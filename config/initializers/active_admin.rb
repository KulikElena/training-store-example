ActiveAdmin.setup do |config|
  # == Site Title
  config.site_title = "Book Store"
  config.comments = false
  # == User Authentication
  config.authentication_method = :authenticate_active_admin_user!

  # == Current User
  config.current_user_method = :current_user

  # == Logging Out
  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete

  # == Batch Actions
  config.batch_actions = true

  # == Attribute Filters
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]

  # == Localize Date/Time Format
  config.localize_format = :long
end
