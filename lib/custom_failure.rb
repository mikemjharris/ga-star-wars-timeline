class CustomFailure < Devise::FailureApp
  def redirect_url
    root_path
  end
  def respond
    if http_auth?
      root_path
    else
      rott_path
    end
  end
end