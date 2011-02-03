class Mobile::SurveyController < ApplicationController
  # your Twilio authentication credentials
  ACCOUNT_SID = 'AC6f5cc3da8ccabab8a32f4b2867246b9c'
  ACCOUNT_TOKEN = 'bb63b8db82de9fca4622def988cc5286'

  # version of the Twilio REST API to use
  API_VERSION = '2010-04-01'

  # base URL of this application
  BASE_URL = "http://demo.twilio.com/appointmentreminder"

  # Outgoing Caller ID you have previously validated with Twilio
  CALLER_ID = '8056174471'
  
  def trigger
    @device = Device.find(params[:device_id])
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    
    begin
      d = {
          'From' => CALLER_ID,
          'To' => @device.participant.cell_number,
          'Body' => 'It is survey time!',
      }
      resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', d)
      resp.error! unless resp.kind_of? Net::HTTPSuccess
    rescue StandardError => bang
      render :text => "<strong>Error #{ bang }</strong> <p>#{resp.body}</p>"
      return
    end
  end
end