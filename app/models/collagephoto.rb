class Collagephoto < ActiveRecord::Base
  attr_accessible :image_url, :user_id

  belongs_to :user
end
