class Mobile::Android::TravelFixesController < ApplicationController  
  before_filter :authenticate_participant!

  def show
    @travel_fix = TravelFix.find(params[:id])

    respond_to do |format|
      format.xml   { render :xml => @travel_fix }
      format.json  { render :json => @travel_fix }
    end
  end

  def create
    @travel_fix = TravelFix.new(params[:travel_fix])
    @travel_fix.participant = current_participant

    respond_to do |format|
      if @travel_fix.save
        format.xml   { render :xml => @travel_fix, :status => :created, :location => mobile_travel_fix_url(@travel_fix) }
        format.json  { render :json => @travel_fix, :status => :created, :location => mobile_travel_fix_url(@travel_fix) }
      else
        format.xml   { render :xml => @travel_fix.errors, :status => :unprocessable_entity }
        format.json  { render :json => @travel_fix.errors, :status => :unprocessable_entity }
      end
    end
  end
end
