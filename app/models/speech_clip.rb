class SpeechClip < ActiveRecord::Base
  has_many :questionnaire_record_fields
end