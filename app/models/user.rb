class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter,  :facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :twittername, :password, :password_confirmation, :remember_me, :uid, :provider, :image 
  # attr_accessible :title, :body

  has_many :collagephotos

  def self.from_omniauth(auth)
    
    twitter_email = if auth.provider =="twitter" then auth.info.nickname.downcase + "@twitter.com" end
    
    
    if user = User.find_by_email(auth.info.email) || user = User.find_by_email(twitter_email) 
      user.provider = auth.provider
      user.uid = auth.uid
      user.image = auth.info.image
      if auth.provider == "facebook"
        user.facebook_token = auth.credentials.token
      end
      user
    else
      
      if auth.provider == "twitter"
          user = User.new()
          user.provider = auth.provider
          user.uid = auth.uid
          user.email = auth.info.nickname.downcase + "@twitter.com"
          user.twittername = auth.info.nickname
          user.image = auth.info.image
          user.password = Devise.friendly_token[0,20]
          user.save
          user

      else

        where(auth.slice(:provider, :uid)).first_or_create do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.email = auth.info.email
            user.image = auth.info.image
            user.password = Devise.friendly_token[0,20]

        end
      end 
    end
  end
end

  
