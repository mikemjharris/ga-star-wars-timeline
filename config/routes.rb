Contacts::Application.routes.draw do



  resources :contacts
  resources :collages
  resources :starwars_facebook
  resources :starwars_twitter


  root to: 'starwars_twitter#index'







end
