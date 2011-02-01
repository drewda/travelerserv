class Participant::SiteController < ApplicationController
  before_filter :authenticate_participant!
  
  def dashboard
    
  end
end