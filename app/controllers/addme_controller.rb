require 'open-uri'
class AddmeController < ApplicationController
  def index
  	graph = Koala::Facebook::GraphAPI.new(current_user.oauth_token)

	#friends = @graph.get_object("/me/albums", "fields"=>"name")
	#friends = @graph.get_object("me") {|data| data['education']} 

	#redirect_to session['oauth'].url_for_oauth_code(:permissions=>'friends_relationships')   
	#@graph.get_connections('me','friends',:fields=>"name,gender,relationship_status")

	#friends = @graph.get_connections('me','albums',:fields=>"name")

	#puts friends.inspect

	# @graph.get_connection("me", "albums", :fields => "name").each do |hash|
 #      puts "-------------->" + hash['name']
 #    end

    # @graph.get_object("me/albums?fields=name,photos.fields(picture)").each do |album|
    #   #puts "-------------->" + hash['photos']['data'].inspect
    # 	#puts album['name']

    # 	album['photos']['data'].each do |picture|
    # 		puts picture['picture']
    # 	end
    # end
	# @oauth = Koala::Facebook::OAuth.new(API_KEYS["facebook"]['app_id'], API_KEYS["facebook"]['app_secret'])
 #    puts @oauth.get_app_access_token.inspect

    @photos = graph.get_object(current_user.uid+"/albums?fields=name,photos.fields(picture,name)")
    #puts current_user.uid+"/albums?fields=name,photos.fields(picture,name)"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end

  end

  def create
    #oauth = Koala::Facebook::OAuth.new(API_KEYS["facebook"]['app_id'], API_KEYS["facebook"]['app_secret'])
    #oauth.url_for_oauth_code(:permissions => "email,user_location,user_about_me,user_photos")
    graph = Koala::Facebook::GraphAPI.new(current_user.oauth_token)
    #graph = Koala::Facebook::API.new(current_user.oauth_token)
    
    #feed = graph.get_connections("100001114368363", "photos")
    #feed = graph.get_object("448766258503849")
    #facebook_feed = ActiveSupport::JSON.decode(feed.to_json)
    #puts ">>>>>>>>>>>>>>>"+facebook_feed.inspect
    photos_id = params[:photos_id]

    deal = Deal.new
    deal.description = params[:description]
    deal.user = current_user
    
    photos_id.each do |p|
      
      fb_photo = graph.get_object("#{p.split('-')[1]}?fields=id,name,source")
      
      photo = Photo.new
      photo.fb_photo_id = fb_photo['id']
      photo.fb_album_id = p.split('-')[0]
      photo.name = fb_photo['name']
      photo.remote_image_url = fb_photo['source']
      
      deal.photos << photo

    end

    deal.save

    respond_to do |format|
          format.html { redirect_to root_path }
          format.js
    end
  end

end
