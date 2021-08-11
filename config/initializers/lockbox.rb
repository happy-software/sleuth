Rails.application.reloader.to_prepare do
  Lockbox.master_key = Configuration::Lockbox.encryption_key
end
