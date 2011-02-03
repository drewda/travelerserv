class Mobile::TravelFixesController < ApplicationController
  # GET /travel_fixes
  # GET /travel_fixes.xml
  def index
    @travel_fixes = TravelFix.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @travel_fixes }
      format.kml
    end
  end

  # GET /travel_fixes/1
  # GET /travel_fixes/1.xml
  def show
    @travel_fix = TravelFix.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @travel_fix }
    end
  end

  # GET /travel_fixes/new
  # GET /travel_fixes/new.xml
  def new
    @travel_fix = TravelFix.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @travel_fix }
    end
  end

  # GET /travel_fixes/1/edit
  def edit
    @travel_fix = TravelFix.find(params[:id])
  end

  # POST /travel_fixes
  # POST /travel_fixes.xml
  def create
    @travel_fix = TravelFix.new(params[:travel_fix])
    @travel_fix.device = Device.where(params[:device]).first
    if @travel_fix.device.participant
      @travel_fix.participant = @travel_fix.device.participant
    end
    @travel_fix.save

    respond_to do |format|
      if @travel_fix.save
        format.html { redirect_to(@travel_fix, :notice => 'Travel fix was successfully created.') }
        format.xml  { render :xml => @travel_fix, :status => :created, :location => mobile_travel_fix_url(@travel_fix) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @travel_fix.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /travel_fixes/1
  # PUT /travel_fixes/1.xml
  def update
    @travel_fix = TravelFix.find(params[:id])

    respond_to do |format|
      if @travel_fix.update_attributes(params[:travel_fix])
        format.html { redirect_to(@travel_fix, :notice => 'Travel fix was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @travel_fix.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /travel_fixes/1
  # DELETE /travel_fixes/1.xml
  def destroy
    @travel_fix = TravelFix.find(params[:id])
    @travel_fix.destroy

    respond_to do |format|
      format.html { redirect_to(travel_fixes_url) }
      format.xml  { head :ok }
    end
  end
end
