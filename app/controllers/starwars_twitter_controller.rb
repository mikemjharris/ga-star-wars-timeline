class StarwarsTwitterController < ApplicationController

  def index


   



    render layout: 'basic'
  end


  def show
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV[TWITTER_STAR_WARS_KEY]
      config.consumer_secret = ENV[TWITTER_STAR_WARS_SECRET]
      config.oauth_token = ENV[TWITTER_STAR_WARS_ACCESS_KEY]
      config.oauth_token_secret = ENV[TWITTER_STAR_WARS_SECRET]
    end

    @tweets = client.user_timeline(params[:id], {count: 20})
    @name = @tweets[0].user.name
    @user_image = @tweets[0].user.profile_image_url
     
    render layout: 'basic' 
  end

end