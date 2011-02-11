class LogEntry < ActiveRecord::Base
  belongs_to :lab
  belongs_to :participant
  belongs_to :experimenter
end