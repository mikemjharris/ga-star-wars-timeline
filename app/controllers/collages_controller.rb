class CollagesController < ApplicationController

def index
   @photos = Collagephoto.where("user_id = #{current_user.id}")
end

def create
  instagram_api_url = "https://api.instagram.com/v1/users/" + current_user.uid + "/media/recent/?access_token="+ current_user.instagram_token
  @instagram_data = HTTParty.get instagram_api_url
  
    @instagram_data['data'].each do | image |
      @collagephoto = Collagephoto.new
      @collagephoto.image_url = image['images']['standard_resolution']['url']
      @collagephoto.user_id = current_user.id
      @collagephoto.save
    end

    redirect_to collages_path

end

def show
  @photos = Collagephoto.find([current_user.id])
end

end
