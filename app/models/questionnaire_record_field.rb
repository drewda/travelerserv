class QuestionnaireRecordField < ActiveRecord::Base
  belongs_to :questionnaire_record
  belongs_to :questionnaire_field
  belongs_to :questionnaire_field_choice
  belongs_to :speech_clip
  belongs_to :image_file
end