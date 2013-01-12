class HomeController < ApplicationController
  def index

   @oauth = Koala::Facebook::OAuth.new(API_KEYS["facebook"]['app_id'], API_KEYS["facebook"]['app_secret'], {:scope => 'email,user_location,user_about_me,user_photos', :display => 'popup'} )
   #puts "------> "+@oauth.get_app_access_token
   #  @graph_app = Koala::Facebook::API.new(@oauth.get_app_access_token)
  	@deals = Deal.all

   # 	@deals.each do |d|
   #     d.photos.each do |f|
   #     	puts @graph_app.get_object(f.fb_photo_id+"?fields=picture,name").inspect
   #     end
   # end

  # 	@fb_deals = graph.get_object(current_user.uid+"/albums?fields=name,photos.fields(picture,name)")
  #   puts @oauth.get_app_access_token.inspect


    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @oauth }
    end

  end
end
