OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  	#provider :facebook, ENV["FACEBOOK_APP_ID"], ENV['FACEBOOK_SECRET']

  	provider :facebook, API_KEYS["facebook"]['app_id'], API_KEYS["facebook"]['app_secret'], {:scope => 'email,user_location,user_about_me,user_photos', :display => 'popup'} 
  	#provider :facebook, API_KEYS["facebook"]['app_id'], API_KEYS["facebook"]['app_secret']

	OmniAuth.config.on_failure = Proc.new do |env|
	#this will invoke the omniauth_failure action in SessionsController.
	"SessionsController".constantize.action(:omniauth_failure).call(env)
	end  
end