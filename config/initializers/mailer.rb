ActionMailer::Base.default_url_options[:host] = Autotest::CONFIG.default_url_options
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.default charset: 'utf-8'

ActionMailer::Base.smtp_settings = {
  address: Autotest::CONFIG.smtp_address,
  port: Autotest::CONFIG.smtp_port,
  domain: Autotest::CONFIG.smtp_domain,
  authentication: :plain,
  enable_starttls_auto: true,
  user_name: Autotest::CONFIG.smtp_user_name,
  password: Autotest::CONFIG.smtp_password
}