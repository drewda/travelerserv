class Activity < ActiveRecord::Base
  # has_many :trips
  belongs_to :participant
  has_many :questionnaire_records
end