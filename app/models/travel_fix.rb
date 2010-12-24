class TravelFix < ActiveRecord::Base
  belongs_to :device
  belongs_to :participant
end
