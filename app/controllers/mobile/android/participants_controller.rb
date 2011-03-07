class Mobile::Android::ParticipantsController < ApplicationController
  before_filter :authenticate_participant!
  
  # GET /participants.xml
  def index
    if current_participant
      @participants = Participant.find(:all, :conditions => {:id => current_participant.id})
    end

    respond_to do |format|
      format.xml  { render :xml => @participants.to_xml(:include => [:devices]) }
      format.json { render :json => @participants.to_json(:include => :devices, :methods => [:default_travel_log_rate, :default_travel_log_adapt_rate]) }
    end
  end
end
