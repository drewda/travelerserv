class ParticipantInStudy < ActiveRecord::Base
  belongs_to :participant
  belongs_to :study
end