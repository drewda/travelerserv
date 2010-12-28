class Api::TravelFixesController < ApplicationController
  ActiveRecord::Base.include_root_in_json = false
    
  def index
    @travel_fixes = Participant.find(params[:participant_id]).travel_fixes

    respond_to do |format|
      format.xml  { render :xml => @travel_fixes }
      format.json { render :json => @travel_fixes }
    end
  end

  def show
    @travel_fix = Participant.find(params[:participant_id]).travel_fixes.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @travel_fix }
      format.json  { render :json => @travel_fix }
    end
  end
end