Travelerserv::Application.routes.draw do
  devise_for :experimenters, :participants

  # api
  namespace :api do
    resources :participants do
      resources :travel_fixes
    end
  end

  # mobile api
  namespace :mobile do
    resources :travel_fixes
    match 'questionnaire_trigger' => 'questionnaire#trigger'
    match 'questionnaire_call/init' => 'questionnaire#call_init'
    match 'questionnaire_call/step_through_questionnaire/' => 'questionnaire#step_through_questionnaire', :as => "questionnaire_call_step_through_questionnaire"
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
