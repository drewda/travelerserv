class Mobile::QuestionnaireController < ApplicationController
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
    @device = Device.where(params[:device]).first
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    
    begin
      d = {
          'From' => CALLER_ID,
          'To' => @device.participant.cell_number,
          'Url' => "http://geocog.geog.ucsb.edu:3001/mobile/questionnaire_call/init.xml?participant_id=#{@device.participant.id}&questionnaire_id=#{@device.participant.participant_in_studies.where(:active=>true)[0].study.start_trip_questionnaire.id}"
      }
      resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls", 'POST', d)
      resp.error! unless resp.kind_of? Net::HTTPSuccess
    rescue StandardError => bang
      render :text => "<strong>Error #{ bang }</strong> <p>#{resp.body}</p>"
      return
    end

    respond_to do |format|
      format.html { render :text => 'ok' } 
      format.xml  { head :ok }
    end
  end
  
  def call_init
    @participant = Participant.find(params[:participant_id])
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
  end
  
  def step_through_questionnaire
    @participant = Participant.find(params[:participant_id])    
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    
    # create QuestionnaireRecord if not already created
    if params['questionnaire_record_id'] and QuestionnaireRecord.find(params['questionnaire_record_id'])
      @questionnaire_record = QuestionnaireRecord.find(params['questionnaire_record_id'])
    else
      @questionnaire_record = QuestionnaireRecord.create(:questionnaire => @questionnaire, 
                                                         :participant => @participant, 
                                                         :filing_interface => "IVR")
      @questionnaire_record.save()
    end

    @stage = params["stage"].to_s
    if @stage == 'repeat'
      @questionnaire_field = QuestionnaireField.find(params['questionnaire_field_id'])
    elsif @stage == 'entry'
      @questionnaire_field = QuestionnaireField.find(params['questionnaire_field_id'])
      response = params['Digits']
    end
    
    # by default, start with the first QuestionnaireField
    if !@questionnaire_field
      @questionnaire_field = @questionnaire.questionnaire_fields[0]
    end

    ### ANY_INTEGER
    if @questionnaire_field.kind == 'any_integer'
      if response.to_s != '*' and response.to_i
        qrf = QuestionnaireRecordField.create(:questionnaire_record => @questionnaire_record,
                                              :questionnaire_field => @questionnaire_field,
                                              :kind => 'any_integer',
                                              :integer => response,
                                              :skipped => false)
        qrf.save()
        go_to_next_or_finish(@participant, @questionnaire, @questionnaire_field, @questionnaire_record)
      elsif response == '*'
        if @questionnaire_field.required == false
          qrf = QuestionnaireRecordField.create(:questionnaire_record => @questionnaire_record,
                                                :questionnaire_field => @questionnaire_field,
                                                :kind => 'any_integer',
                                                :skipped => false)
          qrf.save()
          go_to_next_or_finish(@participant, @questionnaire, @questionnaire_field, @questionnaire_record)
        elsif @questionnaire_field.required == true
          @stage = 'required'
        end
      else
        @stage = 'input_error'
      end
      
    ### INTEGER_SCALE  
    elsif @questionnaire_field.kind == 'integer_scale'
      if response.to_s != '*' and 
         response.to_i and 
         response.to_i >= @questionnaire_field.integer_min_value and 
         response.to_i <= @questionnaire_field.integer_max_value
        qrf = QuestionnaireRecordField.create(:questionnaire_record => @questionnaire_record,
                                             :questionnaire_field => @questionnaire_field,
                                             :kind => 'integer_scale',
                                             :integer => response,
                                             :skipped => false)
        qrf.save()
        go_to_next_or_finish(@participant, @questionnaire, @questionnaire_field, @questionnaire_record)
      elsif response.to_s != '*' and 
        response.to_i and 
        (response.to_i < @questionnaire_field.integer_min_value or response.to_i > @questionnaire_field.integer_max_value)
        @stage = 'input_error'
      elsif response == '*'
        if @questionnaire_field.required == false
          qrf = QuestionnaireRecordField.create(:questionnaire_record => @questionnaire_record,
                                               :questionnaire_field => @questionnaire_field,
                                               :kind => 'integer_scale',
                                               :skipped => true)
          qrf.save()
          go_to_next_or_finish(@participant, @questionnaire, @questionnaire_field, @questionnaire_record)
        elsif @questionnaire_field.required == true
          @stage = 'required'
        end
      else
        @stage = 'input_error'
      end
      
    ### SELCT_FROM_CHOICES
    elsif @questionnaire_field.kind == 'select_from_choices'
      if response.to_s != '*'
        qfc = @questionnaire_field.questionnaire_field_choices[response.to_i]
        qrf = QuestionnaireRecordField.create(:questionnaire_record => @questionnaire_record,
                                             :questionnaire_field => @questionnaire_field,
                                             :kind => 'select_from_choices',
                                             :questionnaire_field_choice => qfc,
                                             :skipped => false)
        qrf.save()
        go_to_next_or_finish(@participant, @questionnaire, @questionnaire_field, @questionnaire_record)
      elsif response == '*'
        if @questionnaire_field.required == false
          qrf = QuestionnaireRecordField.create(:questionnaire_record => @questionnaire_record,
                                               :questionnaire_field => @questionnaire_field,
                                               :kind => 'select_from_choices',
                                               :skipped => true)
          qrf.save()
          go_to_next_or_finish(@participant, @questionnaire, @questionnaire_field, @questionnaire_record)
        elsif @report_form_field.required == true
          @stage = 'required'
        end
      else
        @stage = 'input_error'
      end
      
    ### TEXT_FIELD
    elsif @questionnaire_field.kind == 'text_field'
      if response.to_s != '*'
        audio_url = params['RecordingUrl'].to_s + ".mp3"
        sc = SpeechClip.create(:audio_url => audio_url)
        sc.save()
        qrf = QuestionnaireRecordField.create(:questionnaire_record => @questionnaire_record,
                                             :questionnaire_field => @questionnaire_field,
                                             :kind => 'text_field',
                                             :speech_clip => sc,
                                             :skipped => false)
        qrf.save()
        go_to_next_or_finish(@participant, @questionnaire, @questionnaire_field, @questionnaire_record)
      elsif response == '*'
        if @report_form_field.required == false
          qrf = QuestionnaireRecordField.create(:questionnaire_record => @questionnaire_record,
                                               :questionnaire_field => @questionnaire_field,
                                               :kind => 'text_field',
                                               :skipped => true)
          qrf.save()
          go_to_next_or_finish(@participant, @questionnaire, @questionnaire_field, @questionnaire_record)
        elsif @report_form_field.required == true
          @stage = 'required'
        end
      else
        @stage = 'input_error'
      end
    end

    respond_to do |format|
      format.xml {}
    end
  end

  def go_to_next_or_finish(participant, questionnaire, questionnaire_field, questionnaire_record)
    if next_questionnaire_field = questionnaire.questionnaire_fields.where(:order => (questionnaire_field.order + 1)).first
      @questionnaire_field = next_questionnaire_field
    else
      qr = questionnaire_record
      qr.filed_at = Time.now
      qr.save()
      le = LogEntry.create(:participant => @participant,
                           :lab => @questionnaire.lab,
                           :service => "IVR",
                           :note => "questionnaire filed")
      le.save()
      @stage = 'finished'
    end
  end
end