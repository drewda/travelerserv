class Questionnaire < ActiveRecord::Base
  belongs_to :lab
  has_many :questionnaire_fields
  has_many :questionnaire_records
  has_many :questionnaire_in_studies  
  has_and_belongs_to_many :image_files
  
  has_many :studies_on_trip_start, :class_name => "Study", :foreign_key => :start_trip_questionnaire_id
  has_many :studies_on_trip_end, :class_name => "Study", :foreign_key => :end_trip_questionnaire_id
  has_many :studies_on_activity_start, :class_name => "Study", :foreign_key => :start_activity_questionnaire_id
  has_many :studies_on_activity_end, :class_name => "Study", :foreign_key => :start_activity_questionnaire_id
end