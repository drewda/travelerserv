class ImageFile < ActiveRecord::Base
  has_many :questionnaires
  has_many :questionnaire_record_fields
  has_and_belongs_to_many :questionnaires
  
  has_attached_file :image
end