Contacts::Application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  

  resources :contacts
  resources :collages
  resources :starwars_facebook
  resources :starwars_twitter

    get 'apicalls/instagram', to:  'apicalls#instagram', as: 'instagram_api'
    get 'apicalls/facebook', to:  'apicalls#facebook', as: 'facebook_api'
    get 'apicalls/facebook_auth', to:  'apicalls#facebook_auth', as: 'facebook_auth'
    get 'apicalls/game', to:  'apicalls#game', as: 'game'
    get 'apicalls/hacks', to:  'apicalls#hacks', as: 'hacks'
    get 'contacts/facebookwars', to:  'contacts#facebookwars', as: 'facebookwars'
    
    get 'users/sign_in' => redirect("/"), as: 'new_user_session'

  root to: 'starwars_twitter#index'
    
   
  


 

end
