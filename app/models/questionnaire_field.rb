class QuestionnaireField < ActiveRecord::Base
  belongs_to :questionnaire
  has_many :questionnaire_field_choices
  has_many :questionnaire_record_fields
end