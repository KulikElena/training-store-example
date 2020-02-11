class SecretsLoader
  def call
    secrets = Sekrets.settings_for("./config/sekrets/sekrets.#{Rails.env}.yml.enc") || []
    secrets.each { |key, value| ENV[key.to_s] ||= value.to_s }
  end
end
