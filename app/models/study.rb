class Study < ActiveRecord::Base
  belongs_to :lab
  belongs_to :experimenter
  has_many :participant_in_studies
  has_many :participants, :through => :participant_in_studies
  
  has_many :questionnaire_in_studies
  
  belongs_to :start_trip_questionnaire, :class_name => "Questionnaire"
  belongs_to :end_trip_questionnaire, :class_name => "Questionnaire"
  belongs_to :start_activity_questionnaire, :class_name => "Questionnaire"
  belongs_to :end_activity_questionnaire, :class_name => "Questionnaire"
end