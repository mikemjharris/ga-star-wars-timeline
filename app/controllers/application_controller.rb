class ApplicationController < ActionController::Base
  protect_from_forgery

    

  def after_sign_in_path_for(user)

    starwars_twitter_path(user.twittername)
  end

end
