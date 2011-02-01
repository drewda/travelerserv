Travelerserv::Application.routes.draw do
  devise_for :users, :experimenters, :participants

  # api
  namespace :api do
    resources :participants do
      resources :travel_fixes
    end
  end

  # mobile api
  namespace :mobile do
    resources :travel_fixes
  end
  
  namespace :experimenter do
    root :to => 'site#dashboard'
    resources :participants
    match 'device/:device_id/sms_config' => 'device#sms_config'
  end
  
  namespace :participant do
    root :to => 'site#dashboard'
  end
  
  root :to => 'participant/site#dashboard'
end
