Rails.application.reloader.to_prepare do
  Lockbox.master_key = App::Application.config_for(:lockbox).encryption_key
end
