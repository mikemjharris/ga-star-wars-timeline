class StarwarsFacebookController < ApplicationController

  def index


    @graph = Koala::Facebook::API.new(current_user.facebook_token)
    @facebook_data =  @graph.get_connections(current_user.uid, "photos")

    
    

    @a = []

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


    render layout: 'basic'
  end


end