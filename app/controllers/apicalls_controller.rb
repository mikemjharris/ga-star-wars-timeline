class ApicallsController < ApplicationController

  def instagram

    instagram_api_url = "https://api.instagram.com/v1/users/" + current_user.uid + "/media/recent/?access_token="+ current_user.instagram_token
    @instagram_data = HTTParty.get instagram_api_url

  end


  def facebook

    # facebook_api_url = "https://graph.facebook.com/me/photos?access_token=" + current_user.facebook_token 
    @graph = Koala::Facebook::API.new(current_user.facebook_token)
    @facebook_data =  @graph.get_connections(current_user.uid, "photos")
    # @facebook_data = HTTParty.get instagram_api_url
    # puts response.body, response.code, response.message, response.headers.inspect
    @a = []
     @next_page = @facebook_data.next_page

    @facebook_data.each do |image|
        image_url = image["images"][1]["source"] 
        @a << image_url
    end

    @next_page.each do |image|
        image_url = image["images"][1]["source"] 
        @a << image_url
    end

    @next_page = @next_page.next_page

     @next_page.each do |image|
        image_url = image["images"][1]["source"] 
        @a << image_url
    end

  end



  def facebook_auth
 
    token_url = "https://graph.facebook.com/oauth/access_token?client_id=" + ENV["AUTH_FACEBOOK_KEY"] + "&redirect_uri=http://localhost:3000&client_secret=" + ENV['AUTH_FACEBOOK_SECRET'] + " &code=" + params[:code]
 

    redirect_to :root


  end

def game 
  instagram_api_url = "https://api.instagram.com/v1/users/" + current_user.uid + "/media/recent/?access_token="+ current_user.instagram_token
  @instagram_data = HTTParty.get instagram_api_url
  @instagram_data["data"][0]["images"]["standard_resolution"]["url"]
  @images = []
  @instagram_data["data"].each do |data|
    @images << data["images"]["standard_resolution"]["url"]
  end
   @image = @images.sample 
  render layout: 'basic'

end

  
  def hacks
    # instagram_url = 'https://api.instagram.com/oauth/authorize/?client_id=' + ENV["AUTH_INSTAGRAM_KEY"] + '&redirect_uri=http://localhost:3000&response_type=code'
    # test = HTTParty.get(instagram_url)
    
  end



  def facebookwars

    # facebook_api_url = "https://graph.facebook.com/me/photos?access_token=" + current_user.facebook_token 
    @graph = Koala::Facebook::API.new(current_user.facebook_token)
    @facebook_data =  @graph.get_connections(current_user.uid, "photos")
    # @facebook_data = HTTParty.get instagram_api_url
    # puts response.body, response.code, response.message, response.headers.inspect
    
    

    @a = []
     # @next_page = @facebook_data.next_page
     i = 0
    @facebook_data.each do |image|
      if i > 2
        image_url = image["images"][1]["source"] 
        @a << image_url
      end
      i = 1 + 1
    
    end



    # @next_page.each do |image|
    #     image_url = image["images"][1]["source"] 
    #     @a << image_url
    # end

    # @next_page = @next_page.next_page

    #  @next_page.each do |image|
    #     image_url = image["images"][1]["source"] 
    #     @a << image_url
    # end

    render layout: 'basic'
  end


end