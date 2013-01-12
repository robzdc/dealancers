# Load the rails application
require File.expand_path('../application', __FILE__)

API_KEYS = {"facebook" => {"app_id" => "375355499213650", "app_secret" => "1e482d8af824166b85b5c34ad7024b6d"}}

# Initialize the rails application
Dealancers::Application.initialize!
