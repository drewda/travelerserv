class Api::ParticipantsController < ApplicationController
  # ActiveRecord::Base.include_root_in_json = false

  def index
    @participants = Participant.where(:id => current_participant.id)
    
    # kludge!
    @participants.each do |p|
      p.current_participant = current_participant
    end

    respond_to do |format|
      format.xml  { render :xml => @participants }
      format.json { render :json => @participants.to_json(:methods => [:is_current_participant]) }
    end
  end

  def show
    @participant = Participant.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @participant }
      format.json  { render :json => @participant }
    end
  end
end