class Experimenter::DeviceController < ApplicationController
  
  # your Twilio authentication credentials
  ACCOUNT_SID = 'AC6f5cc3da8ccabab8a32f4b2867246b9c'
  ACCOUNT_TOKEN = 'bb63b8db82de9fca4622def988cc5286'

  # version of the Twilio REST API to use
  API_VERSION = '2010-04-01'

  # base URL of this application
  BASE_URL = "http://demo.twilio.com/appointmentreminder"

  # Outgoing Caller ID you have previously validated with Twilio
  CALLER_ID = '8056174471'

  def sms_config
    @device = Device.find(params[:device_id])
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    
    begin
      d = {
          'From' => CALLER_ID,
          'To' => @device.phone_number,
          'Body' => 'AT+GTSRI=gl100,1,2,wap.cingular,,,128.111.106.226,3000,+16503077748,20081106160119',
      }
      resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', d)
      resp.error! unless resp.kind_of? Net::HTTPSuccess
    rescue StandardError => bang
      render :text => "<strong>Error #{ bang }</strong> <p>#{resp.body}</p>"
      return
    end
    
    begin
      d = {
          'From' => CALLER_ID,
          'To' => @device.phone_number,
          'Body' => 'AT+GTTRI=gl100,0000,2359,1,60,20081106160119',
      }
      resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', d)
      resp.error! unless resp.kind_of? Net::HTTPSuccess
    rescue StandardError => bang
      render :text =>  "Error #{ bang }"
      return
    end
    
    begin
      d = {
          'From' => CALLER_ID,
          'To' => @device.phone_number,
          'Body' => 'AT+GTSFR=gl100,1,0,0,1,1,7,200,1,0,20101112172100',
      }
      resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', d)
      resp.error! unless resp.kind_of? Net::HTTPSuccess
    rescue StandardError => bang
      render :text => "Error #{ bang }"
      return
    end
    
  end
end
