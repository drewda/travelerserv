class Api::ParticipantsController < ApplicationController
  # ActiveRecord::Base.include_root_in_json = false

  def index
    @participants = Participant.all

    respond_to do |format|
      format.xml  { render :xml => @participants }
      format.json { render :json => @participants }
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