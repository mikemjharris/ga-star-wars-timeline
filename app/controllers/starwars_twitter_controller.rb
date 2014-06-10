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
      flash[:nouser] = "No user that name by. Do. Or not do. There is no try"
      redirect_to :root
    else
    # link text
        

    @tweets = client.user_timeline(params[:id], {count: 20})
    @name = @tweets[0].user.name
    @user_image = @tweets[0].user.profile_image_url
    if current_user.twittername = @tweets[0].user.nickname 
          @text = ["Check out my star wars intro twitter feed!", "My timeline starwarsified!"].sample
    else
        @text = ["Checkout " + @name + "'s star wars twitter feed"]    
    end
    render layout: 'basic'
    end 
  end



end