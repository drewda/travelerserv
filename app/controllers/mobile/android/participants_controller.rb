class Mobile::Android::ParticipantsController < ApplicationController
  before_filter :authenticate_participant!
  
  # GET /participants.xml
  def index
    if current_participant
      @participants = Participant.find(:all, :conditions => {:id => current_participant.id})
    end

    respond_to do |format|
      format.xml  { render :xml => @participants }
      format.json { render :json => @participants }
    end
  end
end
