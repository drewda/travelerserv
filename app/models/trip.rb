class Trip < ActiveRecord::Base
  # has_many :activities
  belongs_to :participant
  belongs_to :start_travel_fix_id, :class_name => "TravelFix"
  belongs_to :end_travel_fix_id, :class_name => "TravelFix"
  has_many :questionnaire_records
end