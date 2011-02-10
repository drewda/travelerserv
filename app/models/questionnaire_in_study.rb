class QuestionnaireInStudy < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :study
end