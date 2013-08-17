Obscenity.configure do |config|
  config.blacklist   = "#{Rails.root}/config/blacklist.yml"
  config.replacement = :garbled
end

