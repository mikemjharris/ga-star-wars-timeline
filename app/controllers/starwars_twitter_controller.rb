class StarwarsTwitterController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]


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
      config.oauth_token = ENV["TWITTER_STAR_WARS_ACCESS_KEY"]
      config.oauth_token_secret = ENV["TWITTER_STAR_WARS_SECRET"]
    end

     begin  
      @tweets = client.user_timeline(params[:id], {count: 20})
    rescue 
      flash[:nouser] = "No user that name by. Do. Or do not. There is no try"
      redirect_to :root
    else
    # link text
        

    @tweets = client.user_timeline(params[:id], {count: 20})
    @name = @tweets[0].user.name
    @user_image = @tweets[0].user.profile_image_url

    unless current_user.nil?
      if current_user.twittername == @tweets[0].user.screen_name 
          @text = ["Check out my star wars intro twitter feed!  Made by @mikemjharris", "My timeline starwarsified!  Made by @mikemjharris"].sample
      else
        @text = "Checkout " + @name + "'s Star Wars twitter feed - Made by @mikemjharris"    
      end
    else
        @text = "Checkout " + @name + "'s Star Wars twitter feed. Made by @mikemjharris"

    end
    render layout: 'basic'
    end 
  end



end