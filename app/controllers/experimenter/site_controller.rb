class Experimenter::SiteController < ApplicationController
  before_filter :authenticate_experimenter!
  
  def dashboard
    @participants = Participant.all
    #@travel_fixes = TravelFix.all
  end
end