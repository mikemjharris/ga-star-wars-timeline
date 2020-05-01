class StarwarsTwitterController < ApplicationController

  def index
    if params["twittername"]
      redirect_to :action => 'show', :id => params["twittername"]
    else
      render :index
    end
  end

  def show
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_STAR_WARS_KEY"]
      config.consumer_secret = ENV["TWITTER_STAR_WARS_SECRET"]
      config.access_token = ENV["TWITTER_STAR_WARS_ACCESS_KEY"]
      config.access_token_secret = ENV["TWITTER_STAR_WARS_ACCESS_SECRET"]
    end

    begin
      @tweets = client.user_timeline(params[:id], {count: 20})
    rescue
      flash[:nouser] = "No user that name by. Do. Or do not. There is no try"
      redirect_to :root
    else

    @tweets = client.user_timeline(params[:id], {count: 20})
    @name = @tweets[0].user.name
    @user_image = @tweets[0].user.profile_image_url
    @text = "Checkout " + @name + "'s Star Wars twitter feed. Made by @mikemjharris"
    @preview = "Checkout " + @name + "'s Star Wars twitter feed."
    render layout: 'basic'
    end
  end

end
