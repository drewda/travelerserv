class QuestionnaireFieldChoice < ActiveRecord::Base
  belongs_to :questionnaire_field

  def title
    "#{self.order}: #{self.text}"
  end
end
