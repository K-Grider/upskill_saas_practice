# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Actionmailer::Base.smtp_settings = {
    :port           => EVN['MAILGUN_SMTP_PORT']
    :address        => EVN['MAILGUN_SMTP_SERVER']
    :user_name      => EVN['MAILGUN_SMTP_LOGIN']
    :password       => EVN['MAILGUN_SMTP_PASSWORD']
    :domain         => 'shrouded-dusk-75859.herokuapp.com',
    :authentication => :plain,
}
Actionmailer::Base.delivery_method = :smtp