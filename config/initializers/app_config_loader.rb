if Rails.env.production?
  APP_CONFIG = ENV
else
  raw_config = File.read([Rails.root, 'config', 'app_config.yml'].join('/'))
  APP_CONFIG = YAML.load(raw_config)[Rails.env]
end
