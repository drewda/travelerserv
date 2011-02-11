class QuestionnaireField < ActiveRecord::Base
  belongs_to :questionnaire
  has_many :questionnaire_field_choices
  has_many :questionnaire_record_fields

  def title
    "#{self.order}: #{self.question_text}"
  end
end
