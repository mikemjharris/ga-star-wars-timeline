class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json

  before_filter :authenticate_user!
  
  def index
    
    

  end

  def show
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "hJ23eDcZkYjVDYvMBy2kteQiw"
      config.consumer_secret = "5ctbzoh0Sait9M6xrPH5QBALzJfTonCJRto8Aa4LXGGI3aeGzC"
      config.oauth_token = "20191457-XvHw7Z4gyyrNgKoHEYJED3YvBnxNTXQRDKm0qjw73"
      config.oauth_token_secret = "lSOkbwgaRsP2i2h3zJrDm1DjJBntsrblVXDNVm7uwSof1"
    end

    begin  
      @tweets = client.user_timeline(params[:id], {count: 20})
    rescue 
      redirect_to :root
    end
  end


  def facebookwars
    # facebook_api_url = "https://graph.facebook.com/me/photos?access_token=" + current_user.facebook_token 
    @graph = Koala::Facebook::API.new(current_user.facebook_token)
    @facebook_data =  @graph.get_connections(current_user.uid, "photos")
    
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


    render layout: 'basic'
  end

end
