config = File.join(Rails.root, 'config', 'sekrets.yml.enc')
key = File.join(Rails.root, '.sekrets.key')

if test(?e, config)
  if test(?e, key)
    SEKRETS = Sekrets.settings_for(config)
  else
    SEKRETS = Map.new
    warn "missing #{ key }!"
  end
end
