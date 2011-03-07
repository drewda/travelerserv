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
    
    if @device = Device.where(:identification => params[:device][identification]).first
      @travel_fix.device = @device
    else
      @device = Device.create(:lab => current_participant.lab, 
                              :participant => current_participant,
                              :identification => params[:device][:identification],
                              :kind => params[:device][:kind],
                              :name => params[:device][:name],
                              :travel_log_rate => current_participant.lab.default_travel_log_rate,
                              :travel_log_adapt_rate => current_participant.lab.default_travel_log_adapt_rate)
      @travel_fix.device = @device
    end

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
