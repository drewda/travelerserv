class Api::TravelFixesController < ApplicationController
  def index
    @travel_fixes = TravelFix.all

    respond_to do |format|
      format.xml  { render :xml => @travel_fixes }
      format.json { render :json => @travel_fixes }
    end
  end

  def show
    @travel_fix = TravelFix.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @travel_fix }
    end
  end

  def new
    @travel_fix = TravelFix.new

    respond_to do |format|
      format.xml  { render :xml => @travel_fix }
    end
  end

  def edit
    @travel_fix = TravelFix.find(params[:id])
  end

  def create
    @travel_fix = TravelFix.new(params[:travel_fix])

    respond_to do |format|
      if @travel_fix.save
        format.xml  { render :xml => @travel_fix, :status => :created, :location => @travel_fix }
      else
        format.xml  { render :xml => @travel_fix.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @travel_fix = TravelFix.find(params[:id])

    respond_to do |format|
      if @travel_fix.update_attributes(params[:travel_fix])
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @travel_fix.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @travel_fix = TravelFix.find(params[:id])
    @travel_fix.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end