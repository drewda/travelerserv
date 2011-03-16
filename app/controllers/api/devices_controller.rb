class Api::DevicesController < ApplicationController
  # ActiveRecord::Base.include_root_in_json = false

  def index
    @devices = current_participant.devices;

    respond_to do |format|
      format.xml  { render :xml => @devices }
      format.json { render :json => @devices }
    end
  end

  def show
    @device = Device.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @device }
      format.json  { render :json => @device }
    end
  end
end